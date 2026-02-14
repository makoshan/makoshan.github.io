#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Daily Newsletter .page 生成器

直接从 RSS 源生成 Hakyll .page 格式

用法:
    python generator.py              # 生成今天的 Newsletter
    python generator.py 2026-02-09   # 生成指定日期的 Newsletter
"""

import os
import sys
import io
import re
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Set, Tuple
from collections import defaultdict

# 修复 Windows 控制台编码问题
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# 导入 RSS 抓取模块
try:
    from rss_fetcher import RSSFetcher
    HAS_RSS = True
except ImportError:
    print("[警告] 未找到 rss_fetcher 模块")
    HAS_RSS = False


class NewsletterGenerator:
    """Newsletter .page 格式生成器"""
    
    def __init__(self, output_dir: str = "newsletter"):
        # 根目录是项目根目录（scripts/newsletter的上两级）
        script_dir = Path(__file__).parent
        project_root = script_dir.parent.parent
        self.output_dir = project_root / output_dir
        self.output_dir.mkdir(exist_ok=True)
    
    def fetch_rss_data(self) -> Dict:
        """从 RSS 源获取数据"""
        if HAS_RSS:
            fetcher = RSSFetcher()
            print("[*] 从 RSS 源获取数据...")
            rss_data = fetcher.fetch_all_sources(limit_per_source=10)
            return rss_data
        else:
            return {}
    
    def extract_topics(self, text: str) -> Set[str]:
        """从文本提取主题标签"""
        topics = set()
        
        # 预定义的主题关键词
        topic_keywords = {
            'AI': ['ai', 'gpt', 'llm', 'machine learning', '机器学习', '人工智能', 'openai', 'claude'],
            'Web3': ['blockchain', 'crypto', 'web3', 'defi', 'nft', '区块链', '加密'],
            'Security': ['security', 'hack', 'vulnerability', '安全', '漏洞'],
            'Programming': ['programming', 'code', 'developer', '编程', '开发', 'github'],
            'Rust': ['rust', 'cargo'],
            'Python': ['python', 'pip'],
            'Haskell': ['haskell', 'cabal'],
            'Cloud': ['cloud', 'aws', 'azure', '云计算'],
            'Startup': ['startup', 'founder', 'vc', '创业'],
        }
        
        text_lower = text.lower()
        for topic, keywords in topic_keywords.items():
            for keyword in keywords:
                if keyword.lower() in text_lower:
                    topics.add(topic)
                    break
        
        return topics
    
    def generate_newsletter_page(self, rss_data: Dict, date_str: str) -> Tuple[str, Set[str]]:
        """生成 .page 格式的 Newsletter"""
        
        # 格式化日期
        try:
            dt = datetime.strptime(date_str, '%Y-%m-%d')
            created = dt.strftime('%d %b %Y')  # 09 Feb 2026
            formatted_date = dt.strftime('%Y年%m月%d日')
            weekday = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'][dt.weekday()]
        except:
            created = date_str
            formatted_date = date_str
            weekday = ""
        
        # 收集文章信息和主题
        all_topics = set()
        articles = []
        
        for source_key, source_data in rss_data.items():
            if not source_data.get("articles"):
                continue
            
            for article in source_data["articles"][:10]:
                title = article.get("title", "")
                description = article.get("description", "")
                link = article.get("link", "")
                
                # 提取主题
                topics = self.extract_topics(title + " " + description)
                all_topics.update(topics)
                
                articles.append({
                    'title': title,
                    'description': description,
                    'link': link,
                    'source': source_data['name'],
                    'category': source_data['category'],
                    'topics': topics
                })
        
        # 生成标题和描述
        title = f"每日科技情报 - {formatted_date}"
        topics_str = ", ".join(sorted(all_topics)) if all_topics else "tech, newsletter"
        
        if all_topics:
            topics_preview = ", ".join(list(sorted(all_topics))[:5])
            description = f"每日科技情报。本期关注: {topics_preview}"
        else:
            description = "每日科技情报，包含 AI、Web3、安全、开发工具等领域的精选资讯"
        
        # 生成 .page 内容
        page_content = f"""---
title: {title}
description: "{description}"
tags: newsletter, {topics_str}
created: {created}
status: finished
belief: log
importance: 5
...

# 📊 每日科技情报 | {formatted_date} {weekday}

> 不只是资讯，更有技术趋势与多元观点的碰撞

"""
        
        # 添加本期主题标签
        if all_topics:
            page_content += f"**本期主题**: {' · '.join(f'#{t}' for t in sorted(all_topics))}\n\n"
        
        page_content += "---\n\n## 🔥 今日重点\n\n"
        
        # 添加文章
        for i, article in enumerate(articles[:10], 1):
            # 清理描述
            desc = re.sub(r'<[^>]+>', '', article['description'])
            desc = desc[:300] + "..." if len(desc) > 300 else desc
            
            # 主题标签
            topic_tags = ' '.join(f'#{t}' for t in sorted(article['topics'])) if article['topics'] else ''
            
            page_content += f"""
### {i}. {article['title']}

{topic_tags}

**来源**: [{article['source']}]() · **类别**: {article['category']}

{desc}

🔗 [查看原文]({article['link']})

---

"""
        
        # 添加数据源信息
        page_content += "\n## 📡 数据来源\n\n本期内容聚合自以下平台：\n\n"
        
        for source_key, source_data in rss_data.items():
            article_count = len([a for a in articles if a['source'] == source_data['name']])
            if article_count > 0:
                page_content += f"- **[{source_data['name']}]()** ({source_data['category']}) - {article_count} 条\n"
        
        # 添加元信息
        page_content += f"""

---

## 📮 Newsletter 信息

**更新频率**: 每日 08:00 (北京时间)

**涵盖领域**: 🤖 AI · 🔐 安全 · 💻 开发 · 🚀 创业 · 🌐 Web3

---

## 🧭 导航

- [Newsletter 首页](/newsletter/) - 所有期刊索引
- [主题索引](/newsletter/topics) - 按主题浏览
- [关于本站](/about) - 项目理念

---

*生成于 {created} · 聚合自 {len(rss_data)} 个信息源*
"""
        
        return page_content, all_topics
    
    def save_newsletter(self, content: str, date_str: str) -> Path:
        """保存 Newsletter .page 文件（按年份目录组织）"""
        # 提取年份
        year = date_str.split('-')[0]
        year_dir = self.output_dir / year
        year_dir.mkdir(exist_ok=True)
        
        filename = f"newsletter-{date_str}.page"
        filepath = year_dir / filename
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        
        return filepath
    
    def generate_index_page(self):
        """生成 Newsletter 首页索引"""
        # 查找所有 newsletter .page 文件
        newsletters = []
        for year_dir in sorted(self.output_dir.glob("*"), reverse=True):
            if year_dir.is_dir() and year_dir.name.isdigit():
                newsletters.extend(year_dir.glob("newsletter-*.page"))
        
        newsletters = sorted(newsletters, reverse=True)
        
        index_content = f"""---
title: Newsletter 归档
description: Daily Intel Newsletter 所有期刊索引
tags: newsletter, index
created: {datetime.now().strftime('%d %b %Y')}
status: finished
belief: log
...

# 📧 Newsletter 归档

> Daily Intel 每日科技情报 - 所有期刊

共 {len(newsletters)} 期 Newsletter

---

## 📅 最新期刊

"""
        
        # 最新 10 期
        for nl in newsletters[:10]:
            date_match = re.search(r'newsletter-(\d{4}-\d{2}-\d{2})', nl.name)
            if date_match:
                date = date_match.group(1)
                year = date.split('-')[0]
                index_content += f"- [{date}](/{year}/newsletter-{date})\n"
        
        # 按年归档
        index_content += "\n## 📅 按年浏览\n\n"
        
        by_year = defaultdict(int)
        for nl in newsletters:
            date_match = re.search(r'newsletter-(\d{4})-', nl.name)
            if date_match:
                year = date_match.group(1)
                by_year[year] += 1
        
        for year in sorted(by_year.keys(), reverse=True):
            count = by_year[year]
            index_content += f"- **{year}** - {count} 期\n"
        
        index_content += """

---

[主题索引 →](/newsletter/topics)
"""
        
        # 保存首页
        index_path = self.output_dir / "index.page"
        with open(index_path, 'w', encoding='utf-8') as f:
            f.write(index_content)
        
        print(f"[*] Newsletter 首页已更新: {index_path}")
        return index_path
    
    def generate(self, date_str: str = None) -> Path:
        """生成 Newsletter"""
        if date_str is None:
            date_str = datetime.now().strftime("%Y-%m-%d")
        
        print(f"[*] 生成 {date_str} 的 Newsletter...")
        
        # 1. 获取 RSS 数据
        rss_data = self.fetch_rss_data()
        
        if not rss_data:
            print("[X] 未获取到 RSS 数据")
            return None
        
        # 2. 生成 .page 内容
        print(f"[*] 生成 .page 格式...")
        newsletter_content, topics = self.generate_newsletter_page(rss_data, date_str)
        
        # 3. 保存文件
        filepath = self.save_newsletter(newsletter_content, date_str)
        print(f"[OK] Newsletter 已保存: {filepath}")
        
        # 4. 更新索引页面
        print(f"[*] 更新索引页面...")
        self.generate_index_page()
        
        # 5. 显示主题信息
        if topics:
            print(f"[*] 本期主题: {', '.join(sorted(topics))}")
        
        return filepath


def main():
    """主函数"""
    print("="*60)
    print("Daily Newsletter 生成器")
    print("="*60)
    print()
    
    # 检查依赖
    if not HAS_RSS:
        print("[X] 错误: RSS 模块未安装")
        print("请安装: pip install feedparser")
        sys.exit(1)
    
    # 处理命令行参数
    if len(sys.argv) > 1:
        date_str = sys.argv[1]
    else:
        date_str = None
    
    # 生成
    generator = NewsletterGenerator()
    filepath = generator.generate(date_str)
    
    if filepath:
        print()
        print("[OK] 完成!")
        print()
        print(f"生成的文件: {filepath}")
        print()
        print("下一步:")
        print("  1. 编译: bash scripts/build.sh --skip-convert")
        print("  2. 预览: http://localhost:8000/newsletter/")


if __name__ == "__main__":
    main()
