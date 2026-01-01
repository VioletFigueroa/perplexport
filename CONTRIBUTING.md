# Contributing to Perplexport

Thank you for your interest in contributing to Perplexport! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful, inclusive, and professional in all interactions.

## Getting Started

### Prerequisites

- Node.js 16+
- npm or yarn
- TypeScript knowledge (for code contributions)

### Local Setup

```bash
git clone https://github.com/leonid-shevtsov/perplexport.git
cd perplexport
npm install
npm run build
```

### Development Workflow

```bash
# Watch mode (recompile on changes)
npm run dev

# Build
npm run build

# Run perplexport
npx perplexport -e your-email@example.com -o ./conversations
```

## Making Changes

### Code Style

- Use TypeScript for all code changes
- Follow existing code patterns and conventions
- Use meaningful variable and function names
- Add comments for complex logic

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): short description

Longer explanation if needed
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Examples:
- `feat(cli): add --quiet flag`
- `fix(export): handle empty conversations`
- `docs: update integration guide`

### Testing

- Test your changes before submitting PR
- Ensure TypeScript compiles without errors
- Verify the CLI works with your changes

## Submitting Changes

### Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Commit with descriptive messages
5. Push to your fork
6. Open a Pull Request with:
   - Clear title describing the change
   - Description of what and why
   - Link to related issues if any
   - Screenshots for UI changes

### PR Checklist

- [x] Code follows project style
- [x] TypeScript compiles without errors
- [x] Changes are tested
- [x] Documentation is updated (if needed)
- [x] Commit messages are clear
- [x] No breaking changes (or clearly documented)

## Documentation

### Where to Document

- **README.md** - Main overview (keep concise)
- **docs/** - Detailed guides and references
- **Code comments** - Complex logic explanation
- **Commit messages** - Why changes were made

### Documentation Standards

- Use clear, active language
- Include examples where helpful
- Keep it up-to-date with code changes
- Link between related docs

## Areas for Contribution

### Code

- [ ] Performance improvements
- [ ] New CLI features
- [ ] Bug fixes
- [ ] Error handling improvements
- [ ] Better logging

### Documentation

- [ ] Clarify existing docs
- [ ] Add more examples
- [ ] Fix typos
- [ ] Improve troubleshooting

### Community

- [ ] Help answer issues
- [ ] Share use cases
- [ ] Provide feedback
- [ ] Report bugs with details

## Integration with conversation-to-logseq

This project integrates with [conversation-to-logseq](https://github.com/VioletFigueroa/conversation-to-logseq). When making changes:

1. Ensure the integration still works
2. Update integration documentation
3. Test the `--convert` flag
4. Update scripts in `/scripts`

## Reporting Issues

When reporting a bug, include:

- **Description** - What happened?
- **Steps** - How to reproduce?
- **Expected** - What should happen?
- **Actual** - What actually happened?
- **Environment** - Node version, OS, etc.
- **Error messages** - Full stack trace if available

## Questions or Discussions

- Check existing issues for similar topics
- Read documentation in `/docs`
- Open a discussion or issue

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be:
- Added to acknowledgments in README
- Mentioned in release notes
- Credited in git history

Thank you for making Perplexport better! 🎉
