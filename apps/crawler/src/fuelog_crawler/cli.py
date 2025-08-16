"""
Fuelog Crawler - Command Line Interface

This module provides the main CLI functionality for the Fuelog Crawler tool.
It serves as the primary entry point for both the installed command and
module execution.

The CLI provides basic web crawling capabilities with optional advanced features.
"""

import typer

from fuelog_crawler import __version__


def test_core_features():
    """Test core crawler functionality (always available)."""
    try:
        import bs4
        import httpx
        import pydantic

        print("✅ Core crawler tools available:")
        print(f"  - httpx: {httpx.__version__}")
        print(f"  - beautifulsoup4: {bs4.__version__}")
        print(f"  - pydantic: {pydantic.__version__}")
        return True
    except ImportError as e:
        print(f"❌ Core tools missing: {e}")
        return False


def test_advanced_features():
    """Test advanced functionality (requires advanced group)."""
    try:
        import lxml
        import typer

        print("✅ Advanced tools available:")
        print(f"  - lxml: {lxml.__version__}")
        print(f"  - typer: {typer.__version__}")
        return True
    except ImportError as e:
        print(f"💡 Advanced tools not installed (optional): {e}")
        return False


app = typer.Typer()


@app.command()
def hello(name: str = "world"):
    """Say hello!"""
    print(f"👋 Hello, {name}!")


@app.command()
def info():
    """Show tool info and test features."""
    print(f"🚀 Fuelog Crawler v{__version__}")
    print("📝 A CLI tool scaffold installable via uv tool install")
    print("🔧 Ready to start your development...")
    print("\n🧪 Testing available features:")
    core_available = test_core_features()
    advanced_available = test_advanced_features()
    if core_available and not advanced_available:
        print("\n💡 Install advanced features with:")
        print("   uv sync --group advanced")


def main():
    app()


if __name__ == "__main__":
    main()
