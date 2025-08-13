from pydantic import BaseModel
from typing import Optional


class FuelogCrawlerConfig(BaseModel):
    rate_limit: float = 1.0  # seconds between requests
    user_agent: str = "Fuelog-Crawler/0.1.0"
    timeout: int = 30
    output_format: str = "json"

    # Optional fields for advanced configuration
    max_depth: Optional[int] = None
    follow_links: bool = True
