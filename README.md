# Perplexity Conversation Exporter

Export your Perplexity conversations as JSON and markdown files. Built with TypeScript and Puppeteer.

**NEW:** Automatic conversion to [Logseq](https://logseq.com/) format! 📝

## Quick Start

```bash
# Export conversations
npx perplexport -e your-email@example.com -o ~/conversations

# Export + auto-convert to Logseq
npx perplexport -e your-email@example.com -o ~/conversations --convert
```

Or use the wrapper script:
```bash
./scripts/perplexport-with-logseq.sh -e your-email@example.com -o ~/conversations
```

## Features

- ✅ Exports conversations as JSON + Markdown
- ✅ Automatic Logseq format conversion (optional)
- ✅ Domain classification and tagging
- ✅ Duplicate detection
- ✅ Tracks processed conversations
- ✅ Secure (no credentials stored)

## Documentation

📖 **Start here:** [docs/START_HERE.md](./docs/START_HERE.md)

- **[docs/LOGSEQ_INTEGRATION_GUIDE.md](./docs/LOGSEQ_INTEGRATION_GUIDE.md)** - Complete setup guide
- **[docs/INTEGRATION_QUICK_REFERENCE.md](./docs/INTEGRATION_QUICK_REFERENCE.md)** - Quick reference
- **[scripts/USAGE_EXAMPLES.sh](./scripts/USAGE_EXAMPLES.sh)** - 12 real-world examples
- **[docs/](./docs/)** - Full documentation index

## Installation

### Prerequisites

- Node.js 16+
- Python 3.8+ (for Logseq conversion)

### Setup

```bash
# Option A: Global install
npm install -g perplexport

# Option B: Use via npx (always latest)
npx perplexport -e your-email@example.com -o ~/conversations

# Option C: Clone and build
git clone https://github.com/leonid-shevtsov/perplexport.git
cd perplexport
npm install
npm run build
```

## Usage

```
Usage: npx perplexport [OPTIONS]

Options:
  -e, --email <email>             REQUIRED: Perplexity email
  -o, --output <directory>        Output directory (default: ".")
  -d, --done-file <file>          Done file location (default: "done.json")
  --convert                       Auto-convert to Logseq format
  --converter-path <path>         Path to conversation_converter.py
  --logseq-output <directory>     Output directory for Logseq notes
  -h, --help                      Show this help message
```

## Logseq Integration

The `--convert` flag automatically converts exported conversations to Logseq-compatible notes.

```bash
npx perplexport -e user@example.com -o ~/conversations --convert
```

**What it does:**
- Converts markdown to Logseq format
- Classifies into 10 domain categories
- Generates YAML frontmatter
- Creates tagged, organized notes

See [docs/LOGSEQ_INTEGRATION_GUIDE.md](./docs/LOGSEQ_INTEGRATION_GUIDE.md) for details.

## How It Works

1. Logs in to your Perplexity account
2. Exports all conversations as JSON + Markdown
3. *(Optional)* Converts to Logseq format
4. Tracks processed conversations in done.json

All data stays on your computer. No external services or APIs used.

## Troubleshooting

**Browser won't open or closes instantly:**
```bash
npx puppeteer browsers install chrome
```

**Python not found (for Logseq conversion):**
```bash
python3 --version  # Check if installed
# Install: brew install python3 (macOS) or apt install python3 (Linux)
```

**Converter not found:**
See [docs/LOGSEQ_INTEGRATION_GUIDE.md#troubleshooting](./docs/LOGSEQ_INTEGRATION_GUIDE.md#troubleshooting)

More help: [docs/](./docs/README.md)

## Development

### Prerequisites

- Node.js 16+
- npm or yarn

### Setup

```bash
git clone https://github.com/leonid-shevtsov/perplexport.git
cd perplexport
npm install
npm run build
```

### Development Workflow

```bash
npm run dev              # Watch mode
npm run build            # Build TypeScript
npx perplexport --help  # Test CLI
```

### Project Structure

```
src/
  ├── cli.ts              # Command-line interface
  ├── exportLibrary.ts    # Core export logic
  ├── postExportHook.ts   # Logseq integration
  ├── ConversationSaver.ts
  ├── renderConversation.ts
  └── ...                 # Other modules
scripts/
  └── perplexport-with-logseq.sh  # Wrapper script
docs/
  ├── LOGSEQ_INTEGRATION_GUIDE.md
  └── ...                 # Other documentation
```

See [CONTRIBUTING.md](./CONTRIBUTING.md) for development guidelines.

## Related Projects

- **[conversation-to-logseq](https://github.com/VioletFigueroa/conversation-to-logseq)** - Logseq conversion tool

## License

MIT License - see [LICENSE](./LICENSE)

## Credits

- Original: [Leonid Shevtsov](https://leonid.shevtsov.me)
- Logseq Integration: [Violet Figueroa](https://github.com/VioletFigueroa)

---

**Questions?** Check [docs/START_HERE.md](./docs/START_HERE.md) or open an issue.

