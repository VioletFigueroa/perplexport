import { Page } from "puppeteer";
import { Conversation, DoneFile } from "./types";
import { sleep } from "./utils";

export async function scrollToBottomOfConversations(
  page: Page,
  doneFile: DoneFile
): Promise<void> {
  // Scroll to bottom and wait for more items until no new items load
  let previousHeight = 0;
  let currentHeight = await page.evaluate(() => {
    const container = document.querySelector("div.scrollable-container") || 
                     document.querySelector('[role="main"]') ||
                     document.body;
    return container?.scrollHeight || document.documentElement.scrollHeight;
  });

  let scrollAttempts = 0;
  const maxScrollAttempts = 20;

  while (previousHeight !== currentHeight && scrollAttempts < maxScrollAttempts) {
    // Check if we've hit any processed URLs
    const foundProcessed = await page.evaluate((processedUrls) => {
      const items = Array.from(
        document.querySelectorAll('a[href*="/search/"], a[href*="/thread/"]')
      ) as HTMLAnchorElement[];
      return items.some((item) => processedUrls.includes(item.href));
    }, doneFile.processedUrls);

    if (foundProcessed) {
      console.log("Found already processed conversation, stopping scroll");
      break;
    }

    // Scroll to bottom
    await page.evaluate(() => {
      const container = document.querySelector("div.scrollable-container") || 
                       document.querySelector('[role="main"]') ||
                       document.documentElement;
      if (container) {
        container.scrollTo(0, container.scrollHeight);
      }
    });

    // Wait a bit for content to load
    await sleep(2000);

    previousHeight = currentHeight;
    currentHeight = await page.evaluate(() => {
      const container = document.querySelector("div.scrollable-container") || 
                       document.querySelector('[role="main"]') ||
                       document.body;
      return container?.scrollHeight || document.documentElement.scrollHeight;
    });
    
    scrollAttempts++;
  }
  
  if (scrollAttempts >= maxScrollAttempts) {
    console.log("Reached maximum scroll attempts, proceeding with found conversations");
  }
}

export async function getConversations(
  page: Page,
  doneFile: DoneFile
): Promise<Conversation[]> {
  console.log("Navigating to library...");
  await page.goto("https://www.perplexity.ai/library");

  // Try multiple selectors as Perplexity UI changes frequently
  const selectors = [
    'div[data-testid="thread-title"]',
    'a[href*="/search/"]',
    'a[href*="/thread/"]',
    '[role="listitem"] a',
    '.thread-item',
    'div[class*="thread"] a'
  ];
  
  let foundSelector = null;
  for (const selector of selectors) {
    try {
      await page.waitForSelector(selector, { timeout: 5000 });
      foundSelector = selector;
      console.log(`Found threads with selector: ${selector}`);
      break;
    } catch (e) {
      // Continue to next selector
    }
  }
  
  if (!foundSelector) {
    throw new Error(`Could not find any conversation threads. Page content: ${await page.content()}`);
  }

  await scrollToBottomOfConversations(page, doneFile);

  // Get all conversation links - try primary selector first, then fallbacks
  const conversations = await page.evaluate((selector) => {
    let items: HTMLAnchorElement[] = [];
    
    // Try the found selector
    const threadElements = Array.from(document.querySelectorAll(selector));
    for (const el of threadElements) {
      const link = el.closest("a") as HTMLAnchorElement;
      if (link && link.href) {
        items.push(link);
      }
    }
    
    // Fallback: look for any links containing thread or search in href
    if (items.length === 0) {
      items = Array.from(document.querySelectorAll('a[href*="/search/"], a[href*="/thread/"]'));
    }
    
    // Remove duplicates
    const seen = new Set<string>();
    items = items.filter(item => {
      if (seen.has(item.href)) return false;
      seen.add(item.href);
      return true;
    });
    
    return items.map((item) => ({
      title: item.textContent?.trim() || "Untitled",
      url: item.href,
    }));
  }, foundSelector);

  // Filter out already processed conversations and reverse the order
  return conversations
    .filter((conv) => !doneFile.processedUrls.includes(conv.url))
    .reverse();
}
