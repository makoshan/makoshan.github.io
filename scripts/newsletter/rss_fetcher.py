# RSS 抓取模块

import feedparser
from typing import List, Dict

class RSSFetcher:
    """RSS 内容抓取器"""
    
    def __init__(self):
        self.sources = {
            # 原有源
            "newshacker": {
                "name": "News Hacker",
                "url": "https://api.newshacker.me/rss",
                "category": "极客洞察",
                "limit": 10
            },
            "hacker_podcast": {
                "name": "Hacker Podcast",
                "url": "https://hacker-podcast.agi.li/rss.xml",
                "category": "播客",
                "limit": 5
            },
            
            # 新增源 - 国际平台
            "hackernews": {
                "name": "Hacker News",
                "url": "https://hnrss.org/frontpage?points=50",  # 高质量文章
                "category": "开源&AI",
                "limit": 15
            },
            "github_trending": {
                "name": "GitHub Trending",
                "url": "https://mshibanami.github.io/GitHubTrendingRSS/daily/all.xml",
                "category": "开源项目",
                "limit": 10
            },
            
            # 新增源 - 中文平台
            "sspai": {
                "name": "少数派",
                "url": "https://sspai.com/feed",
                "category": "生活科技",
                "limit": 10
            },
            "wallstreetcn": {
                "name": "华尔街见闻",
                "url": "https://rsshub.app/wallstreetcn/news/global",  # 全球要闻
                "category": "财经市场",
                "limit": 10
            },

            # 新增源 - AI 强化版
            "huggingface": {
                "name": "Hugging Face Blog",
                "url": "https://huggingface.co/blog/feed.xml",
                "category": "AI 模型",
                "limit": 8
            },
            "ruanyifeng": {
                "name": "阮一峰网络日志",
                "url": "https://www.ruanyifeng.com/blog/atom.xml",
                "category": "技术周刊",
                "limit": 5
            },
            "producthunt": {
                "name": "Product Hunt",
                "url": "https://rsshub.app/producthunt/today",
                "category": "新产品",
                "limit": 10
            }
        }
    
    def fetch_feed(self, feed_url: str, limit: int = 10) -> List[Dict]:
        """抓取单个 RSS feed"""
        try:
            feed = feedparser.parse(feed_url)
            articles = []
            
            for entry in feed.entries[:limit]:
                article = {
                    "title": entry.get("title", ""),
                    "link": entry.get("link", ""),
                    "description": entry.get("description", ""),
                    "published": entry.get("published", ""),
                    "published_parsed": entry.get("published_parsed"),
                    "author": entry.get("author", ""),
                    "source": feed.feed.get("title", "Unknown")
                }
                articles.append(article)
            
            return articles
            
        except Exception as e:
            print(f"Error fetching {feed_url}: {e}")
            return []
    
    def fetch_all_sources(self, limit_per_source: int = None) -> Dict:
        """抓取所有配置的 RSS 源"""
        results = {}
        
        for key, config in self.sources.items():
            print(f"Fetching {config['name']}...")
            # 使用源自己的 limit，如果没有则使用参数的 limit，最后默认 10
            limit = config.get('limit', limit_per_source or 10)
            articles = self.fetch_feed(config["url"], limit)
            results[key] = {
                "name": config["name"],
                "category": config["category"],
                "articles": articles
            }
        
        return results
    
    def add_source(self, key: str, name: str, url: str, category: str = "其他"):
        """添加新的 RSS 源"""
        self.sources[key] = {
            "name": name,
            "url": url,
            "category": category
        }


# 便捷函数
def fetch_rss_sources() -> Dict:
    """
    抓取所有配置的 RSS 源
    
    返回:
        {
            "newshacker": {
                "name": "News Hacker",
                "category": "极客洞察",
                "articles": [...]
            },
            ...
        }
    """
    fetcher = RSSFetcher()
    return fetcher.fetch_all_sources()


if __name__ == "__main__":
    print("RSS Fetcher - Testing")
    print()
    
    fetcher = RSSFetcher()
    print("Available sources:")
    for key, config in fetcher.sources.items():
        print(f"  - {config['name']} ({config['url']})")
    
    print("\nFetching News Hacker RSS (3 articles)...")
    articles = fetcher.fetch_feed("https://api.newshacker.me/rss", 3)
    for i, a in enumerate(articles, 1):
        print(f"{i}. {a['title'][:60]}...")
