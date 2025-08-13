"""
Fuelog Crawler - Module execution entry point.

This module enables the package to be executed as:
    python -m fuelog_crawler
    uv run python -m fuelog_crawler

The module delegates execution to the main CLI function.
"""

from fuelog_crawler.cli import main

if __name__ == "__main__":
    main()
