#!/bin/bash

# INTEGRATION USAGE EXAMPLES
# Real-world scenarios showing how to use the integrated workflow

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_example() {
  echo ""
  echo -e "${BLUE}═══════════════════════════════════════════${NC}"
  echo -e "${GREEN}Example $1${NC}"
  echo -e "${BLUE}═══════════════════════════════════════════${NC}"
  echo ""
}

print_command() {
  echo -e "${YELLOW}$ $1${NC}"
}

print_description() {
  echo -e "  Description: $1"
}

print_result() {
  echo -e "  Result: ${GREEN}$1${NC}"
}

# ============================================================================
print_example "1: Basic Export with Auto-Conversion"
# ============================================================================
print_description "Export all conversations and automatically convert to Logseq format"
print_command "npx perplexport -e john@example.com -o ~/conversations --convert"

echo ""
echo "  What this does:"
echo "    1. Exports all Perplexity conversations to ~/conversations/"
echo "    2. Saves as JSON (complete backup) and Markdown (rendered)"
echo "    3. Automatically converts to Logseq format"
echo "    4. Saves organized notes to ~/conversations/logseq-notes/"
echo ""
print_result "~1,000 conversations in 30-50 minutes"
echo ""

# ============================================================================
print_example "2: Custom Output Directory"
# ============================================================================
print_description "Export to a specific location with custom Logseq output"
print_command "perplexport -e john@example.com \\"
echo "               -o ~/data/perplexity/exports \\"
echo "               --convert \\"
echo "               --logseq-output ~/Documents/Logseq/pages/conversations"

echo ""
echo "  What this does:"
echo "    1. Exports to ~/data/perplexity/exports/"
echo "    2. Converts to Logseq format"
echo "    3. Saves Logseq notes directly to ~/Documents/Logseq/pages/conversations"
echo ""
print_result "Logseq notes immediately in your graph directory"
echo ""

# ============================================================================
print_example "3: Using the Wrapper Script"
# ============================================================================
print_description "Use wrapper script for better progress feedback and auto-detection"
print_command "./perplexport-with-logseq.sh -e john@example.com -o ~/conversations"

echo ""
echo "  What this does:"
echo "    1. Auto-detects converter path"
echo "    2. Shows color-coded progress"
echo "    3. Provides helpful next steps after completion"
echo "    4. Better error handling and recovery"
echo ""
print_result "Seamless workflow with visual feedback"
echo ""

# ============================================================================
print_example "4: Quiet Mode for Automation"
# ============================================================================
print_description "Run in quiet mode for cron jobs or automated scripts"
print_command "./perplexport-with-logseq.sh -e john@example.com -o ~/conversations --quiet"

echo ""
echo "  What this does:"
echo "    1. Minimizes output (only errors shown)"
echo "    2. Good for automated/scheduled runs"
echo "    3. Easy to parse results"
echo ""
print_result "Suitable for cron jobs, systemd timers, GitHub Actions"
echo ""

# ============================================================================
print_example "5: Manual Two-Step Process"
# ============================================================================
print_description "Run export and conversion separately for maximum control"
print_command "# Step 1: Export conversations"
echo "npx perplexport -e john@example.com -o ~/conversations"
echo ""
print_command "# (Optional: Review or modify the markdown files)"
echo "ls ~/conversations/*.md | head -5"
echo ""
print_command "# Step 2: Convert to Logseq"
echo "python3 ~/Tools/conversation_converter.py \\"
echo "  --input-dir ~/conversations \\"
echo "  --output-dir ~/conversations/logseq-notes"

echo ""
echo "  When to use this:"
echo "    1. Troubleshooting integration issues"
echo "    2. Modifying conversations between export and conversion"
echo "    3. Different timing for export vs conversion"
echo "    4. Maximum control over each step"
echo ""
print_result "Full control and visibility into each step"
echo ""

# ============================================================================
print_example "6: Incremental Updates (Using Done File)"
# ============================================================================
print_description "Run multiple times to only export new conversations"
print_command "# Run 1: Initial export"
echo "perplexport -e john@example.com -o ~/conversations --convert"
echo ""
print_command "# (Later) Run 2: Only exports NEW conversations"
echo "perplexport -e john@example.com -o ~/conversations --convert"

echo ""
echo "  What this does:"
echo "    1. First run: Exports all conversations, creates done.json"
echo "    2. Second run: Reads done.json, skips already-exported conversations"
echo "    3. Only new conversations are exported and converted"
echo "    4. Tracks progress in done.json"
echo ""
print_result "Only 2-5 minutes for incremental updates"
echo ""

# ============================================================================
print_example "7: Automate with Cron (Daily Export)"
# ============================================================================
print_description "Schedule automatic daily exports at 9 AM"
echo ""
echo "  Add to crontab:"
print_command "crontab -e"
echo ""
echo "  Then add this line:"
echo "    0 9 * * * /home/user/perplexport-with-logseq.sh -e john@example.com -o ~/conversations -q"
echo ""
echo "  What this does:"
echo "    1. Runs every day at 9:00 AM"
echo "    2. Exports new conversations"
echo "    3. Automatically converts to Logseq"
echo "    4. Runs silently (only shows errors)"
echo ""
print_result "Fresh Logseq notes every morning"
echo ""

# ============================================================================
print_example "8: Import Converted Notes into Logseq"
# ============================================================================
print_description "After conversion, copy notes to your Logseq graph"
print_command "# Option A: Copy files"
echo "cp -r ~/conversations/logseq-notes/* ~/Logseq/my-graph/pages/"
echo ""
print_command "# Option B: Create symlink (changes sync automatically)"
echo "ln -s ~/conversations/logseq-notes ~/Logseq/my-graph/pages/perplexity"

echo ""
echo "  What this does:"
echo "    1. Copies/links converted notes to Logseq"
echo "    2. Logseq automatically indexes them"
echo "    3. Makes them queryable by tags and domains"
echo ""
print_result "Notes now visible in Logseq, organized by domain"
echo ""

# ============================================================================
print_example "9: Query Conversations in Logseq"
# ============================================================================
print_description "Use Logseq queries to find specific conversations"
echo ""
echo "  In your Logseq graph, create a new page with:"
echo ""
echo "    {{query (page-tag \"technology\")}}"
echo "    -> Shows all technology conversations"
echo ""
echo "    {{query (and (page-tag \"learning\") (page-tag \"nodejs\"))}}"
echo "    -> Shows learning conversations tagged with nodejs"
echo ""
echo "    {{query (not (page-tag \"career\"))}}"
echo "    -> Shows all conversations EXCEPT career-related"
echo ""
echo "  Domain categories available:"
echo "    • career, business, technology, learning"
echo "    • data, productivity, knowledge, health"
echo "    • finance, creative"
echo ""
print_result "Powerful querying across 1,000+ conversations"
echo ""

# ============================================================================
print_example "10: Verify Everything Works"
# ============================================================================
print_description "Test all components are installed and working"
print_command "# Check Node.js"
echo "node --version"
echo ""
print_command "# Check perplexport"
echo "perplexport --version"
echo "  OR"
echo "npx perplexport --version"
echo ""
print_command "# Check Python"
echo "python3 --version"
echo ""
print_command "# Check converter"
echo "python3 ~/Tools/conversation_converter.py --help"
echo ""
print_command "# List existing exports"
echo "ls ~/conversations/logseq-notes/ | head -10"

echo ""
print_result "All components working - ready to use!"
echo ""

# ============================================================================
print_example "11: Troubleshooting - Converter Not Found"
# ============================================================================
print_description "What to do if converter isn't auto-detected"
print_command "# Find where it is"
echo "find ~ -name \"conversation_converter.py\" 2>/dev/null"
echo ""
print_command "# Explicitly specify the path"
echo "perplexport -e john@example.com --convert \\"
echo "  --converter-path /path/to/conversation_converter.py"

echo ""
print_result "Converter found and used explicitly"
echo ""

# ============================================================================
print_example "12: Check Conversion Results"
# ============================================================================
print_description "Verify that conversion completed successfully"
print_command "# Count converted notes"
echo "ls ~/conversations/logseq-notes/ | wc -l"
echo ""
print_command "# Check file sizes"
echo "du -sh ~/conversations/logseq-notes/"
echo ""
print_command "# View a sample note"
echo "head -30 ~/conversations/logseq-notes/*.md | head -1"
echo ""
print_command "# Check YAML frontmatter"
echo "grep -E \"^(title|domain|tags):\" ~/conversations/logseq-notes/*.md | head -5"

echo ""
print_result "Conversion complete and verified"
echo ""

# ============================================================================
echo ""
echo -e "${BLUE}═══════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ All Examples Complete${NC}"
echo -e "${BLUE}═══════════════════════════════════════════${NC}"
echo ""
echo "  For more information, see:"
echo "    📖 LOGSEQ_INTEGRATION_GUIDE.md - Complete guide"
echo "    📖 INTEGRATION_QUICK_REFERENCE.md - Quick reference"
echo "    📖 INTEGRATION_SUMMARY.md - Technical summary"
echo ""
echo "  Resources:"
echo "    🔗 https://github.com/leonid-shevtsov/perplexport"
echo "    🔗 https://github.com/VioletFigueroa/conversation-to-logseq"
echo ""
