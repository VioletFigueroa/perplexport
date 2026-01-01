# Documentation

Complete documentation for Perplexport and its Logseq integration.

## Getting Started

- **[START_HERE.md](./START_HERE.md)** - Quick overview and next steps
- **[INTEGRATION_QUICK_REFERENCE.md](./INTEGRATION_QUICK_REFERENCE.md)** - One-page quick reference

## Complete Guides

- **[LOGSEQ_INTEGRATION_GUIDE.md](./LOGSEQ_INTEGRATION_GUIDE.md)** - Complete integration setup guide with troubleshooting
- **[INTEGRATION_SUMMARY.md](./INTEGRATION_SUMMARY.md)** - Technical deep dive into the integration architecture

## Reference

- **[INTEGRATION_CHECKLIST.md](./INTEGRATION_CHECKLIST.md)** - Verification of all integration components

## In the Root

- **README.md** - Main project readme
- **CONTRIBUTING.md** - Guide for contributors
- **LICENSE** - MIT License

## In /scripts

- **perplexport-with-logseq.sh** - Wrapper script for orchestration
- **USAGE_EXAMPLES.sh** - 12 real-world usage examples

## In /examples

- **extract_intended_usage.sh** - Example script

## Quick Links

| Need | Document |
|------|----------|
| **Quick start** | [START_HERE.md](./START_HERE.md) |
| **Setup instructions** | [LOGSEQ_INTEGRATION_GUIDE.md](./LOGSEQ_INTEGRATION_GUIDE.md) |
| **One-page reference** | [INTEGRATION_QUICK_REFERENCE.md](./INTEGRATION_QUICK_REFERENCE.md) |
| **Technical details** | [INTEGRATION_SUMMARY.md](./INTEGRATION_SUMMARY.md) |
| **Real examples** | [../scripts/USAGE_EXAMPLES.sh](../scripts/USAGE_EXAMPLES.sh) |
| **Troubleshooting** | [LOGSEQ_INTEGRATION_GUIDE.md#troubleshooting](./LOGSEQ_INTEGRATION_GUIDE.md#troubleshooting) |
| **Want to contribute?** | [../CONTRIBUTING.md](../CONTRIBUTING.md) |

## Documentation Structure

```
perplexport/
├── README.md                          # Main overview
├── CONTRIBUTING.md                    # Contribution guide
├── LICENSE                            # MIT License
├── docs/                              # All documentation
│   ├── START_HERE.md                  # Start here!
│   ├── LOGSEQ_INTEGRATION_GUIDE.md    # Complete guide
│   ├── INTEGRATION_SUMMARY.md         # Technical details
│   ├── INTEGRATION_QUICK_REFERENCE.md # Quick ref
│   ├── INTEGRATION_CHECKLIST.md       # Verification
│   └── README.md                      # This file
├── scripts/
│   ├── perplexport-with-logseq.sh     # Wrapper script
│   └── USAGE_EXAMPLES.sh              # Usage examples
├── examples/
│   └── extract_intended_usage.sh      # Example script
├── src/
│   ├── cli.ts                         # CLI interface
│   ├── exportLibrary.ts               # Core logic
│   ├── postExportHook.ts              # Integration hook
│   └── ...                            # Other source files
├── dist/                              # Compiled output
├── node_modules/                      # Dependencies
├── package.json                       # Project config
├── tsconfig.json                      # TypeScript config
└── .gitignore                         # Git ignore rules
```

## How to Use This Documentation

### I'm new to Perplexport

1. Read [START_HERE.md](./START_HERE.md) (5 min)
2. Skim [LOGSEQ_INTEGRATION_GUIDE.md](./LOGSEQ_INTEGRATION_GUIDE.md) (20 min)
3. Try the examples in [../scripts/USAGE_EXAMPLES.sh](../scripts/USAGE_EXAMPLES.sh)

### I want to use it right now

1. Check [INTEGRATION_QUICK_REFERENCE.md](./INTEGRATION_QUICK_REFERENCE.md)
2. Copy a command
3. Run it!

### I need troubleshooting help

1. See [LOGSEQ_INTEGRATION_GUIDE.md#troubleshooting](./LOGSEQ_INTEGRATION_GUIDE.md#troubleshooting)
2. Search related issue on GitHub
3. Open a new issue if not found

### I want to contribute

1. Read [../CONTRIBUTING.md](../CONTRIBUTING.md)
2. Check [INTEGRATION_SUMMARY.md](./INTEGRATION_SUMMARY.md) for architecture
3. Make your changes
4. Submit a pull request

### I need technical details

1. Read [INTEGRATION_SUMMARY.md](./INTEGRATION_SUMMARY.md)
2. Check the source code in `/src`
3. Review the implementation

## Documentation Standards

All documentation in this project follows these standards:

- ✅ Clear, active language
- ✅ Examples where helpful
- ✅ Links between related docs
- ✅ Proper formatting (Markdown)
- ✅ Up-to-date with code
- ✅ Organized by topic

## Contributing to Documentation

See [../CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

Quick tips:
- Keep language clear and active
- Include examples
- Link related topics
- Update when code changes
- Test commands before documenting

---

Last updated: 2025-01-01
