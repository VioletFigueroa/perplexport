#!/usr/bin/env node

import { Command } from "commander";
import exportLibrary from "./exportLibrary";

const program = new Command();

program
  .name("perplexport")
  .description("Export Perplexity conversations as markdown files")
  .version("1.0.0")
  .option("-o, --output <directory>", "Output directory for conversations", ".")
  .option(
    "-d, --done-file <file>",
    "Done file location (tracks which URLs have been downloaded before)",
    "done.json"
  )
  .option(
    "--convert",
    "Automatically convert exported conversations to Logseq format"
  )
  .option(
    "--converter-path <path>",
    "Path to conversation_converter.py (auto-detected if not provided)"
  )
  .option(
    "--logseq-output <directory>",
    "Output directory for Logseq notes (defaults to output/logseq-notes)"
  )
  .requiredOption("-e, --email <email>", "Perplexity email")
  .parse();

const options = program.opts();

async function main(): Promise<void> {
  await exportLibrary({
    outputDir: options.output,
    doneFilePath: options.doneFile,
    email: options.email,
    convertToLogseq: options.convert,
    converterPath: options.converterPath,
    logseqOutputDir: options.logseqOutput,
  });
}

main().catch((error) => {
  console.error("Fatal error:", error);
  process.exit(1);
});
