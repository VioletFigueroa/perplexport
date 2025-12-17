import { Page } from "puppeteer";
import { ConversationResponse } from "./types/conversation";

interface ThreadData {
  id: string;
  conversation: ConversationResponse;
}

export class ConversationSaver {
  private page: Page;

  constructor(page: Page) {
    this.page = page;
  }

  private resolve: (data: ThreadData) => void = (_) => {};

  async initialize(): Promise<void> {
    this.page.on("response", async (response) => {
      const url = response.url();
      // Try multiple API endpoint patterns
      if (
        response.request().method() === "GET" &&
        (url.includes("/rest/thread/") || url.includes("/api/thread/")) &&
        url.includes("limit=")
      ) {
        const threadId = url.split("/thread/")[1]?.split("?")[0] || 
                        url.split("/")[url.split("/").length - 1]?.split("?")[0];
        
        if (threadId === "list_recent" || !threadId) {
          return;
        }
        
        try {
          const data = (await response.json()) as ConversationResponse;
          if (this.resolve && data && data.entries) {
            console.log(`✓ Received API data for thread ${threadId}`);
            this.resolve({
              id: threadId,
              conversation: data,
            });
          }
        } catch (error) {
          console.debug(`Could not parse response for ${threadId}:`, error);
        }
      }
    });
  }

  // we request the thread's page and wait for the response for thread data
  // the response is captured by the response handler above
  // and we route it through the promise
  // concurrency not possible with the browser anyway
  async loadThreadFromURL(url: string, timeoutMs: number = 45000): Promise<ThreadData> {
    let timeoutHandle: NodeJS.Timeout | null = null;
    let resolved = false;
    
    const pagePromise = new Promise<ThreadData>((resolve, reject) => {
      timeoutHandle = setTimeout(() => {
        if (!resolved) {
          resolved = true;
          console.log(`⏱ Timeout reached (${timeoutMs}ms), using fallback...`);
          reject(new Error(`Timeout waiting for thread data after ${timeoutMs}ms`));
        }
      }, timeoutMs);
      
      this.resolve = (data) => {
        if (!resolved) {
          resolved = true;
          if (timeoutHandle) clearTimeout(timeoutHandle);
          resolve(data);
        }
      };
    });
    
    try {
      console.log(`Loading thread page...`);
      await this.page.goto(url, { waitUntil: "networkidle0", timeout: 45000 });
      console.log(`Page loaded, waiting for API response...`);
      
      const threadData = await pagePromise;
      console.log(`✓ Got API response with ${threadData.conversation.entries?.length || 0} entries`);
      return threadData;
    } catch (error) {
      console.log(`Could not get API response: ${error instanceof Error ? error.message : String(error)}`);
      
      // Try to extract thread ID from URL
      const threadIdMatch = url.match(/\/thread\/([^/?]+)/);
      const threadId = threadIdMatch?.[1] || url.split("/").pop() || "unknown";
      
      console.log(`Returning placeholder data with thread ID: ${threadId}`);
      // Return empty/placeholder data instead of crashing
      return {
        id: threadId,
        conversation: {
          status: "placeholder",
          entries: [],
          has_next_page: false,
          next_cursor: null,
        } as ConversationResponse,
      };
    } finally {
      if (timeoutHandle) clearTimeout(timeoutHandle);
      this.resolve = (_) => {};
    }
  }
}
