# Quick Reference: Perplexport + Logseq Integration

## Three Ways to Integrate

### 1️⃣ CLI Flag (Simplest)
```bash
npx perplexport -e user@example.com -o ~/conversations --convert
```

### 2️⃣ Wrapper Script (Full Control)
```bash
./perplexport-with-logseq.sh -e user@example.com -o ~/conversations
```

### 3️⃣ Manual Two-Step
```bash
npx perplexport -e user@example.com -o ~/conversations
python3 conversation_converter.py --input-dir ~/conversations --output-dir ~/conversations/logseq-notes
```

---

## Complete CLI Reference

### Perplexport with Conversion

```bash
perplexport [OPTIONS]

OPTIONS:
  -e, --email <email>                    REQUIRED: Perplexity email
  -o, --output <dir>                     Output directory (default: .)
  -d, --done-file <file>                 Done file path (default: done.json)
  --convert                              Auto-convert to Logseq format
  --converter-path <path>                Path to conversion script
  --logseq-output <dir>                  Logseq output directory
  --help                                 Show help

EXAMPLES:
  perplexport -e john@example.com --convert
  perplexport -e john@example.com -o ~/data --convert --logseq-output ~/logseq
```

### Wrapper Script

```bash
perplexport-with-logseq.sh [OPTIONS]

OPTIONS:
  -e, --email <email>                    REQUIRED: Perplexity email
  -o, --output <dir>                     Output directory (default: .)
  -d, --done-file <file>                 Done file path (default: done.json)
  --converter-path <path>                Path to conversion script
  --logseq-output <dir>                  Logseq output directory
  -q, --quiet                            Minimize output
  -h, --help                             Show help

EXAMPLES:
  ./perplexport-with-logseq.sh -e john@example.com -o ~/conversations
  ./perplexport-with-logseq.sh -e john@example.com -o ~/conversations -q
```

---

## Output Structure

```
~/conversations/
├── *.json                          # Raw conversation data
├── *.md                            # Rendered conversations
├── done.json                       # Tracking
└── logseq-notes/                   # ← Ready for Logseq!
    └── *.md                        # Tagged, organized notes
```

---

## Logseq Note Format

```yaml
---
title: "Question/Topic"
source: "perplexity"
source_url: "https://..."
created_date: "2025-01-01"
domain: ["technology", "learning"]  # Auto-categorized
tags: ["topic1", "topic2"]
---

## Conversation

[Full conversation content with formatting]
```

---

## Domain Categories

The converter auto-tags conversations:

| Domain | Examples |
|--------|----------|
| 💼 career | Job search, interviews, resume |
| 🏢 business | Startups, strategy, management |
| 💻 technology | Programming, software, deployment |
| 📚 learning | Courses, education, tutorials |
| 📊 data | Analytics, databases, data science |
| 🎯 productivity | Workflows, tools, organization |
| 🌍 knowledge | General info, research, facts |
| 🏥 health | Wellness, fitness, medicine |
| 💰 finance | Money, investing, budgeting |
| 🎨 creative | Writing, art, design |

---

## Common Tasks

### Import into Logseq

```bash
cp -r ~/conversations/logseq-notes/* ~/Logseq/your-graph/pages/
```

### Query by Domain

In Logseq, use page tags:

```
{{query (page-tag "technology")}}
{{query (and (page-tag "learning") (page-tag "nodejs"))}}
{{query (not (page-tag "career"))}}
```

### View Conversion Progress

```bash
ls ~/conversations/logseq-notes/ | wc -l      # Count notes
du -sh ~/conversations/logseq-notes/            # Total size
```

### Automate with Cron

```bash
# Add to crontab (run daily at 9 AM)
0 9 * * * /path/to/perplexport-with-logseq.sh -e user@example.com -o ~/conversations -q
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Converter not found" | Specify path: `--converter-path /path/to/script` |
| "Python not found" | Install: `brew install python3` or `apt install python3` |
| "Conversion hangs" | Run manually to debug: `python3 script.py --input-dir ... --output-dir ...` |
| "Wrong domain tags" | Edit YAML frontmatter manually or report issue |

---

## Performance

| Metric | Value |
|--------|-------|
| Export speed | ~2-5 min per 100 conversations |
| Conversion speed | ~50-100 conversations/sec |
| Memory usage | ~50MB for 1,200 conversations |
| Disk per 100 notes | ~2-5MB |

---

## File Locations

| Tool | Location |
|------|----------|
| perplexport | Global: `perplexport` / Local: `npx perplexport` |
| conversation_converter.py | Where you cloned conversation-to-logseq repo |
| Wrapper script | `perplexport-with-logseq.sh` in perplexport repo |

---

## Links

- 📖 [Full Integration Guide](./LOGSEQ_INTEGRATION_GUIDE.md)
- 🔗 [Perplexport Repo](https://github.com/leonid-shevtsov/perplexport)
- 🔗 [Conversation-to-Logseq Repo](https://github.com/VioletFigueroa/conversation-to-logseq)

---

**Last Updated:** 2025-01-01
