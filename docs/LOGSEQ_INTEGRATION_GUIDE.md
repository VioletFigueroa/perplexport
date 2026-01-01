# Perplexport + Logseq Integration Guide

## Overview

This guide explains how to automatically convert Perplexity conversations to Logseq-compatible notes using the integrated workflow.

**What this does:**
1. Exports Perplexity conversations using `perplexport`
2. Automatically converts them to Logseq format using `conversation-to-logseq`
3. Generates tagged, organized notes ready for your Logseq graph

## Three Integration Approaches

Choose the approach that best fits your workflow:

### Option 1: CLI Flag (Recommended)

Use the `--convert` flag with perplexport directly:

```bash
npx perplexport -e user@example.com -o ~/conversations --convert
```

**Pros:**
- ✅ Seamless integration
- ✅ Single command
- ✅ Auto-detects conversation converter
- ✅ Best for regular exports

**When to use:**
- You want the simplest one-command workflow
- You export conversations frequently
- You have both tools installed

**Requirements:**
- `conversation_converter.py` installed in a detectable location
- Python 3.8+

### Option 2: Wrapper Script

Use the provided bash wrapper for full orchestration:

```bash
./perplexport-with-logseq.sh -e user@example.com -o ~/conversations
```

**Pros:**
- ✅ Full control over both tools
- ✅ Better error handling
- ✅ Custom output directories
- ✅ Works on any system with bash

**When to use:**
- You want detailed progress feedback
- You need custom output paths
- You prefer bash scripting
- Running on Windows (via WSL/Git Bash)

**Features:**
- Auto-detects converter path
- Color-coded output
- Helpful next steps
- Error recovery

### Option 3: Manual Two-Step Process

Run each tool separately for maximum control:

```bash
# Step 1: Export conversations
npx perplexport -e user@example.com -o ~/conversations

# Step 2: Convert to Logseq
python3 conversation_converter.py \
  --input-dir ~/conversations \
  --output-dir ~/conversations/logseq-notes
```

**Pros:**
- ✅ Maximum flexibility
- ✅ Easiest to debug
- ✅ Can modify between steps

**When to use:**
- You're troubleshooting integration issues
- You need to modify conversations before conversion
- You want full control

## Installation & Setup

### Prerequisites

1. **Node.js** (16+) - for perplexport
   ```bash
   node --version  # Should be v16 or higher
   ```

2. **Python** (3.8+) - for conversation-to-logseq
   ```bash
   python3 --version  # Should be 3.8 or higher
   ```

3. **Both tools installed**

### Install perplexport

```bash
# Option A: Global install (recommended)
npm install -g perplexport

# Option B: Use directly with npx
npx perplexport -e user@example.com -o ~/conversations
```

### Install conversation-to-logseq

```bash
# Clone the repository
git clone https://github.com/VioletFigueroa/conversation-to-logseq.git

# No additional dependencies needed!
# It uses only Python stdlib
```

### Verify Installation

Test that everything works:

```bash
# Test 1: Check perplexport
perplexport --version
# Output: 1.0.0 (or similar)

# Test 2: Check converter
python3 /path/to/conversation_converter.py --help
# Output: usage: conversation_converter.py [-h] --input-dir INPUT_DIR ...
```

## Usage Examples

### Example 1: Basic Export with Conversion

```bash
perplexport -e john@example.com -o ~/conversations --convert
```

**What happens:**
1. Launches browser and logs into Perplexity
2. Exports all conversations as JSON + Markdown
3. Automatically converts to Logseq format
4. Saves organized notes to `~/conversations/logseq-notes/`

### Example 2: Custom Output Directories

Using the wrapper script:

```bash
./perplexport-with-logseq.sh \
  -e john@example.com \
  -o ~/data/perplexity-export \
  --logseq-output ~/documents/logseq-graph/pages/perplexity
```

### Example 3: Specify Converter Path

If auto-detection fails:

```bash
perplexport -e john@example.com -o ~/conversations --convert \
  --converter-path ~/my-tools/conversation_converter.py
```

### Example 4: Quiet Mode

For non-interactive / automated scripts:

```bash
./perplexport-with-logseq.sh \
  -e john@example.com \
  -o ~/conversations \
  --quiet
```

### Example 5: Custom Done File

Track processed conversations separately:

```bash
perplexport -e john@example.com \
  -o ~/conversations \
  --done-file ~/.config/perplexity-done.json \
  --convert
```

## Output Structure

After running the integrated workflow, you'll have:

```
~/conversations/
├── 1234567890.json              # Raw conversation data
├── 1234567890.md                # Rendered HTML as markdown
├── 9876543210.json
├── 9876543210.md
├── done.json                    # Tracks which conversations are processed
└── logseq-notes/                # ← Ready for Logseq!
    ├── 2025-01-01_technology_abc123.md
    ├── 2025-01-01_learning_def456.md
    ├── 2025-01-02_career_ghi789.md
    └── ... (100+ notes)
```

### Logseq Note Format

Each converted note includes:

```markdown
---
title: "How to set up a Node.js project"
source: "perplexity"
source_url: "https://www.perplexity.ai/search/..."
created_date: "2025-01-01"
domain: ["technology"]
tags: ["nodejs", "setup", "learning"]
---

## Conversation

**User:** How do I set up a new Node.js project?

**Assistant:** Here's a step-by-step guide...

[Full conversation content]
```

## Domain Tagging

The converter automatically categorizes conversations into domains:

- 💼 **career** - Job search, resume, interviews
- 🏢 **business** - Business strategy, startups
- 💻 **technology** - Programming, software
- 📚 **learning** - Education, courses
- 📊 **data** - Analytics, data science
- 🎯 **productivity** - Workflows, tools
- 🌍 **knowledge** - General information
- 🏥 **health** - Health, wellness
- 💰 **finance** - Financial planning
- 🎨 **creative** - Writing, art, design

Query conversations in Logseq by domain:

```
{{query (page-tag "technology")}}
{{query (and (page-tag "learning") (page-tag "nodejs"))}}
```

## Troubleshooting

### Issue: "Converter not found"

**Symptom:** When using `--convert` flag, you get a warning about missing converter

**Solution:**

1. Check if converter is installed:
   ```bash
   find ~ -name "conversation_converter.py" 2>/dev/null
   ```

2. Explicitly specify path:
   ```bash
   perplexport -e user@example.com -o ~/conversations --convert \
     --converter-path /exact/path/to/conversation_converter.py
   ```

3. Or use the wrapper script which has better path detection:
   ```bash
   ./perplexport-with-logseq.sh -e user@example.com -o ~/conversations
   ```

### Issue: "Python not found" or "python3 command not found"

**Symptom:** Error about Python not being available

**Solution:**

1. Check Python installation:
   ```bash
   which python3
   ```

2. If not found, install Python:
   - Ubuntu/Debian: `sudo apt install python3`
   - macOS: `brew install python3`
   - Windows: Download from python.org

3. Verify installation:
   ```bash
   python3 --version
   ```

### Issue: Conversion starts but doesn't complete

**Symptom:** Export succeeds but conversion hangs

**Solution:**

1. Run conversion manually to see detailed output:
   ```bash
   python3 /path/to/conversation_converter.py \
     --input-dir ~/conversations \
     --output-dir ~/conversations/logseq-notes
   ```

2. Check for error messages
3. Verify file permissions: `chmod -R 755 ~/conversations`
4. Check disk space: `df -h`

### Issue: "No module named 'puppeteer'" or similar Node.js errors

**Symptom:** Error when running perplexport

**Solution:**

1. Reinstall perplexport:
   ```bash
   npm install -g perplexport@latest
   ```

2. Or use npx to bypass cache:
   ```bash
   npx perplexport@latest -e user@example.com -o ~/conversations --convert
   ```

### Issue: Logseq notes have wrong domain tags

**Symptom:** Conversations tagged with incorrect domains

**Solution:**

1. This is a classification issue in the converter
2. Manually edit the YAML frontmatter:
   ```yaml
   domain: ["career", "learning"]  # Add multiple domains
   ```

3. Report to: https://github.com/VioletFigueroa/conversation-to-logseq/issues

## Advanced Configuration

### Automate Daily Exports

Create a cron job (macOS/Linux):

```bash
# Run daily at 9 AM
0 9 * * * /home/user/perplexport-with-logseq.sh -e user@example.com -o ~/conversations -q
```

### Integrate with Logseq

After conversion, copy notes to your Logseq graph:

```bash
# Copy the Logseq notes
cp -r ~/conversations/logseq-notes/* ~/Logseq/my-graph/pages/

# Or create a symbolic link (changes sync automatically)
ln -s ~/conversations/logseq-notes ~/Logseq/my-graph/pages/perplexity-conversations
```

### Monitor Conversion Progress

Check how many conversations have been converted:

```bash
ls ~/conversations/logseq-notes/ | wc -l
du -sh ~/conversations/logseq-notes/
```

## Performance Notes

- **Export speed:** ~2-5 minutes per 100 conversations (browser automation)
- **Conversion speed:** ~50-100 conversations per second (local processing)
- **Memory usage:** ~50MB for 1,200 conversations
- **Disk usage:** ~2-5MB per 100 conversations (with markdown + JSON)

## API & Development

### Using in Custom Scripts

**Node.js:**

```typescript
import exportLibrary from "perplexport";

await exportLibrary({
  outputDir: "./conversations",
  doneFilePath: "./done.json",
  email: "user@example.com",
  convertToLogseq: true,
  converterPath: "/path/to/conversation_converter.py",
  logseqOutputDir: "./logseq-notes"
});
```

**Python:**

```python
from conversation_converter import ConversationConverter

converter = ConversationConverter(
    input_dir="./conversations",
    output_dir="./logseq-notes"
)
converter.convert_directory()
```

## Security & Privacy

⚠️ **Important:**
- All conversation data is stored locally
- No data is sent to external services
- Browser automation logs you in interactively
- Done file tracks processed URLs only

## Support

- 📖 [Perplexport Documentation](https://github.com/leonid-shevtsov/perplexport)
- 📖 [Conversation-to-Logseq Documentation](https://github.com/VioletFigueroa/conversation-to-logseq)
- 🐛 [Report Issues](https://github.com/VioletFigueroa/conversation-to-logseq/issues)

## Next Steps

1. **Install both tools**
2. **Choose your preferred integration approach** (CLI flag, wrapper, or manual)
3. **Run your first export:** See above examples
4. **Import into Logseq** and enjoy organized conversations!
