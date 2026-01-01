#!/bin/bash

# perplexport-with-logseq.sh
# 
# Integrated wrapper for perplexport + conversation-to-logseq
# Automatically exports Perplexity conversations and converts them to Logseq format
#
# Usage:
#   ./perplexport-with-logseq.sh -e user@example.com -o ./conversations
#   ./perplexport-with-logseq.sh -e user@example.com -o ./conversations --converter-path /path/to/conversation_converter.py
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default values
OUTPUT_DIR="."
EMAIL=""
CONVERTER_PATH=""
LOGSEQ_OUTPUT=""
QUIET=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -e|--email)
      EMAIL="$2"
      shift 2
      ;;
    -o|--output)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    -d|--done-file)
      DONE_FILE="$2"
      shift 2
      ;;
    --converter-path)
      CONVERTER_PATH="$2"
      shift 2
      ;;
    --logseq-output)
      LOGSEQ_OUTPUT="$2"
      shift 2
      ;;
    --quiet|-q)
      QUIET=true
      shift
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

show_help() {
  cat << EOF
${BLUE}perplexport-with-logseq${NC} - Export Perplexity conversations to Logseq

${GREEN}USAGE:${NC}
  perplexport-with-logseq.sh [OPTIONS]

${GREEN}REQUIRED OPTIONS:${NC}
  -e, --email <email>               Perplexity email address

${GREEN}OPTIONAL OPTIONS:${NC}
  -o, --output <directory>          Output directory for conversations
                                    Default: current directory

  -d, --done-file <file>            Done file location
                                    Default: done.json

  --converter-path <path>           Path to conversation_converter.py
                                    Auto-detected if not provided

  --logseq-output <directory>       Output directory for Logseq notes
                                    Default: <output>/logseq-notes

  -q, --quiet                       Suppress verbose output

  -h, --help                        Show this help message

${GREEN}EXAMPLES:${NC}
  # Export and automatically convert to Logseq
  ./perplexport-with-logseq.sh -e user@example.com -o ~/conversations

  # Specify custom paths
  ./perplexport-with-logseq.sh -e user@example.com \\
    -o ~/conversations \\
    --converter-path ~/tools/conversation_converter.py \\
    --logseq-output ~/Documents/logseq-notes

  # Quiet mode (minimal output)
  ./perplexport-with-logseq.sh -e user@example.com -o ~/conversations -q

${GREEN}WORKFLOW:${NC}
  1. Exports Perplexity conversations as JSON and Markdown
  2. Automatically converts Markdown to Logseq-compatible notes
  3. Saves Logseq notes with domain tags and metadata
  4. Tracks processed conversations in done.json

${GREEN}OUTPUT STRUCTURE:${NC}
  <output>/
    ├── *.json                   # Raw conversation data
    ├── *.md                     # Rendered conversations
    ├── done.json                # Tracking file
    └── logseq-notes/            # Logseq-formatted notes
        └── *.md                 # Ready for Logseq

${GREEN}SEE ALSO:${NC}
  perplexport: https://github.com/leonid-shevtsov/perplexport
  conversation-to-logseq: https://github.com/VioletFigueroa/conversation-to-logseq

EOF
}

# Validate required arguments
if [[ -z "$EMAIL" ]]; then
  echo -e "${RED}✗ Error: Email is required${NC}"
  echo ""
  show_help
  exit 1
fi

# Find converter if not provided
if [[ -z "$CONVERTER_PATH" ]]; then
  echo -e "${YELLOW}🔍 Searching for conversation_converter.py...${NC}"
  
  # Common locations
  possible_paths=(
    "$SCRIPT_DIR/../conversation-to-logseq/conversation_converter.py"
    "$SCRIPT_DIR/../../conversation-to-logseq/conversation_converter.py"
    "$HOME/Development/Github/conversation-to-logseq/conversation_converter.py"
    "/usr/local/bin/conversation_converter.py"
  )
  
  for path in "${possible_paths[@]}"; do
    if [[ -f "$path" ]]; then
      CONVERTER_PATH="$path"
      echo -e "${GREEN}✓ Found converter at: $CONVERTER_PATH${NC}"
      break
    fi
  done
  
  if [[ -z "$CONVERTER_PATH" ]]; then
    echo -e "${YELLOW}⚠ Could not find conversation_converter.py${NC}"
    echo -e "  Install it from: ${BLUE}https://github.com/VioletFigueroa/conversation-to-logseq${NC}"
    echo -e "  Or specify path with: ${BLUE}--converter-path <path>${NC}"
    echo ""
    echo -e "${YELLOW}Proceeding with export only (no Logseq conversion)${NC}"
  fi
fi

# Set default logseq output directory if converter found
if [[ -z "$LOGSEQ_OUTPUT" && ! -z "$CONVERTER_PATH" ]]; then
  LOGSEQ_OUTPUT="$OUTPUT_DIR/logseq-notes"
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Perplexport with Logseq Conversion${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  📧 Email:            ${GREEN}$EMAIL${NC}"
echo -e "  📁 Output:           ${GREEN}$OUTPUT_DIR${NC}"

if [[ ! -z "$CONVERTER_PATH" ]]; then
  echo -e "  🐍 Converter:        ${GREEN}$CONVERTER_PATH${NC}"
  echo -e "  📝 Logseq Output:    ${GREEN}$LOGSEQ_OUTPUT${NC}"
else
  echo -e "  🐍 Converter:        ${YELLOW}Not found (export only)${NC}"
fi

echo ""
echo -e "${BLUE}Step 1/2: Exporting Perplexity conversations...${NC}"
echo ""

# Run perplexport
npx perplexport \
  -e "$EMAIL" \
  -o "$OUTPUT_DIR" \
  ${DONE_FILE:+-d "$DONE_FILE"}

export_exit_code=$?

if [[ $export_exit_code -ne 0 ]]; then
  echo -e "${RED}✗ Export failed with exit code $export_exit_code${NC}"
  exit $export_exit_code
fi

echo ""
echo -e "${GREEN}✓ Export complete!${NC}"
echo ""

# Run conversion if converter was found
if [[ ! -z "$CONVERTER_PATH" ]]; then
  echo -e "${BLUE}Step 2/2: Converting to Logseq format...${NC}"
  echo ""
  
  # Create logseq output directory
  mkdir -p "$LOGSEQ_OUTPUT"
  
  # Build converter command
  converter_cmd="python3 \"$CONVERTER_PATH\" --input-dir \"$OUTPUT_DIR\" --output-dir \"$LOGSEQ_OUTPUT\""
  
  if [[ "$QUIET" == true ]]; then
    converter_cmd="$converter_cmd --quiet"
  fi
  
  # Run the conversion
  if eval "$converter_cmd"; then
    echo ""
    echo -e "${GREEN}✓ Conversion complete!${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "  ${GREEN}✓ All done!${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  📁 Raw exports:      ${GREEN}$OUTPUT_DIR${NC}"
    echo -e "  📝 Logseq notes:     ${GREEN}$LOGSEQ_OUTPUT${NC}"
    echo ""
    echo -e "  Next steps:"
    echo -e "    1. Copy notes to your Logseq graph: ${BLUE}cp -r $LOGSEQ_OUTPUT/* ~/Logseq/your-graph/pages/${NC}"
    echo -e "    2. Refresh your Logseq app"
    echo -e "    3. Query by domain tags: ${BLUE}{{query (and (page-tag \"technology\") (page-tag \"learning\"))}}${NC}"
    echo ""
  else
    conversion_exit_code=$?
    echo -e "${RED}✗ Conversion failed with exit code $conversion_exit_code${NC}"
    exit $conversion_exit_code
  fi
else
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "  ${GREEN}✓ Export complete!${NC}"
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo -e "  📁 Exports:          ${GREEN}$OUTPUT_DIR${NC}"
  echo ""
  echo -e "  To enable Logseq conversion:"
  echo -e "    1. Install converter: ${BLUE}https://github.com/VioletFigueroa/conversation-to-logseq${NC}"
  echo -e "    2. Run with: ${BLUE}./perplexport-with-logseq.sh -e $EMAIL -o $OUTPUT_DIR --converter-path <path>${NC}"
  echo ""
fi

exit 0
