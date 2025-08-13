"""
Fuelog Crawler - Command Line Interface

This module provides the main CLI functionality for the Fuelog Crawler tool.
It serves as the primary entry point for both the installed command and 
module execution.

The CLI currently provides a basic scaffold implementation that can be
extended with actual crawler functionality.
"""

from fuelog_crawler import __version__


def main() -> None:
    """
    Main entry point for the Fuelog Crawler CLI.
    
    This function is called when the tool is executed via:
    - fuelog-crawler (when installed via uv tool install)
    - python -m fuelog_crawler
    - uv run fuelog-crawler
    
    Currently displays a welcome message and version information.
    This serves as a scaffold for implementing actual crawler functionality.
    """
    print(f"🚀 Fuelog Crawler v{__version__}")
    print("📝 A CLI tool scaffold installable via uv tool install")
    print("🔧 Ready to start your development...")


if __name__ == "__main__":
    # This allows the module to be executed directly for testing
    main()
