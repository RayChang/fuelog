
# Fuelog Crawler

A modern Python data crawler tool built with [typer](https://typer.tiangolo.com/) CLI framework. Features web scraping capabilities with httpx and BeautifulSoup, data validation with Pydantic, and comprehensive development tooling.


## 📁 Project Structure

```
apps/crawler/
├── src/
│   └── fuelog_crawler/     # Main package
│       ├── __init__.py     # Package initialization
│       ├── __main__.py     # Support for python -m execution
│       ├── cli.py          # CLI main logic
│       ├── config.py       # Configuration management with Pydantic
│       └── exceptions.py   # Custom exception classes
├── tests/
│   ├── __init__.py
│   └── test_basic.py       # Basic tests with improved path handling
├── pyproject.toml          # Project configuration and dependencies
├── package.json            # npm/turbo script configuration
├── uv.lock                 # Dependency lock file
└── README.md               # Project documentation
```


## 🚀 Quick Start

### Install Dependencies

```bash
# Install all dependencies (including dev dependencies)
uv sync

# Install only production dependencies
uv sync --no-dev
```



### CLI Usage Examples

After installation, you can use the CLI directly:

```bash
# Run CLI commands
fuelog-crawler hello
fuelog-crawler info

# Or use python -m
python -m fuelog_crawler info
```



### System Installation

```bash
# Install globally
uv tool install .

# Use the installed command
fuelog-crawler hello
```


## 🛠️ Development

### Code Quality

```bash
# Lint check
npm run lint

# Auto-fix lint issues
npm run lint:fix

# Type checking
npm run check-types
```

### Testing

```bash
# Run tests
npm run test

# Run failed tests only (useful for TDD)
npm run test:watch
```

### Build

```bash
# Build package
npm run build
```


## 🏗️ Turbo Integration

This project is integrated into the monorepo's turbo workflow:

```bash
# Execute from root directory
pnpm turbo run python:test --filter=crawler
pnpm turbo run python:lint --filter=crawler
pnpm turbo run python:run --filter=crawler
```


## 📦 Tech Stack

### Core Dependencies
- **Python 3.13+** - Runtime environment
- **httpx** - Modern HTTP client for web requests
- **BeautifulSoup4** - HTML/XML parsing
- **Pydantic** - Data validation and configuration management
- **Typer** - CLI framework with type hints

### Development Tools
- **uv** - Fast dependency management and tooling
- **Hatchling** - Modern build backend
- **Ruff** - Fast linting and code formatting
- **MyPy** - Static type checking (with lxml-stubs)
- **pytest** - Testing framework


## 🗑️ Uninstall

```bash
uv tool uninstall fuelog-crawler
```



## 💡 CLI Extension Guide

This tool uses [typer](https://typer.tiangolo.com/) as the CLI framework, making it easy to add new commands:

1. Add a new function in `src/fuelog_crawler/cli.py` and decorate it with `@app.command()`
2. Reinstall/sync dependencies to use the new command

Example:

```python
import typer
app = typer.Typer()

@app.command()
def hello(name: str = "world"):
	print(f"👋 Hello, {name}!")

if __name__ == "__main__":
	app()
```

## 🔧 Architecture & Development Workflow

### Key Modules

- **`config.py`** - Configuration management using Pydantic models
  ```python
  from fuelog_crawler.config import CrawlerConfig
  config = CrawlerConfig(rate_limit=2.0, timeout=60)
  ```

- **`exceptions.py`** - Custom exception hierarchy
  ```python
  from fuelog_crawler.exceptions import CrawlerError, NetworkError
  ```

### Development Workflow

1. **Add new features**: Create new modules in `src/fuelog_crawler/`
2. **Extend CLI**: Edit `src/fuelog_crawler/cli.py` using typer decorators
3. **Write tests**: Add test files in the `tests/` directory
4. **Update dependencies**: Edit `dependencies` in `pyproject.toml`
5. **Run quality checks**: Use `npm run lint`, `npm run check-types`, and `npm run test`

### Testing Best Practices

- Tests use dynamic path resolution for better portability
- Type checking includes lxml stubs for comprehensive coverage
- Use `npm run test:watch` for TDD workflow (runs only failed tests)


## 📄 License

This project follows the license in the project root directory.
