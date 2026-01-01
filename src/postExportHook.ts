import { spawn } from "child_process";
import { promises as fs } from "fs";
import path from "path";

/**
 * Post-export hook to automatically run conversation-to-logseq conversion
 * Converts markdown conversations to Logseq-compatible notes
 */
export async function runPostExportConversion(
  outputDir: string,
  converterPath: string,
  convertOutputDir?: string
): Promise<void> {
  console.log("\n📝 Running post-export conversion to Logseq format...");

  // Determine the output directory for Logseq notes
  const logseqOutputDir =
    convertOutputDir || path.join(outputDir, "logseq-notes");

  // Ensure the output directory exists
  await fs.mkdir(logseqOutputDir, { recursive: true });

  return new Promise((resolve, reject) => {
    // Spawn the Python converter as a subprocess
    const pythonProcess = spawn("python3", [
      converterPath,
      "--input-dir",
      outputDir,
      "--output-dir",
      logseqOutputDir,
      "--quiet",
    ]);

    let stdoutData = "";
    let stderrData = "";

    pythonProcess.stdout?.on("data", (data) => {
      const output = data.toString();
      stdoutData += output;
      process.stdout.write(output);
    });

    pythonProcess.stderr?.on("data", (data) => {
      const output = data.toString();
      stderrData += output;
      process.stderr.write(output);
    });

    pythonProcess.on("close", (code) => {
      if (code === 0) {
        console.log(
          `✅ Conversion complete! Logseq notes saved to: ${logseqOutputDir}`
        );
        resolve();
      } else {
        console.error(`❌ Conversion failed with exit code ${code}`);
        reject(
          new Error(`Conversion process exited with code ${code}: ${stderrData}`)
        );
      }
    });

    pythonProcess.on("error", (error) => {
      console.error("❌ Failed to start conversion process:", error);
      reject(error);
    });
  });
}

/**
 * Check if the converter script exists at the given path
 */
export async function checkConverterExists(converterPath: string): Promise<boolean> {
  try {
    await fs.access(converterPath);
    return true;
  } catch {
    return false;
  }
}

/**
 * Attempt to find the conversation_converter.py in common locations
 */
export async function findConverter(): Promise<string | null> {
  const commonPaths = [
    // Relative to perplexport (if installed as a dependency)
    "../conversation-to-logseq/conversation_converter.py",
    "../../conversation-to-logseq/conversation_converter.py",
    
    // Absolute paths where it might be installed
    "/usr/local/lib/node_modules/perplexport/conversation_converter.py",
    path.expandUser("~/Development/Github/conversation-to-logseq/conversation_converter.py"),
  ];

  for (const converterPath of commonPaths) {
    const expandedPath = path.expandUser(converterPath);
    if (await checkConverterExists(expandedPath)) {
      return expandedPath;
    }
  }

  return null;
}

/**
 * Helper to expand ~ in paths (cross-platform)
 */
path.expandUser = function expandUser(p: string) {
  if (p === "~") return process.env.HOME || "";
  if (p.startsWith("~/")) return (process.env.HOME || "") + p.slice(1);
  return p;
};
