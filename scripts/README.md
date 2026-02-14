# Daily Intel 增强版 - 需求说明

## 新增功能

### 1. HN 评论抓取与 AI 分析
- **功能**: 抓取 Hacker News 文章评论，AI 分类总结
- **展示**: 支持/反对/质疑/补充等不同观点
- **技术**: HN Firebase API + OpenAI GPT-4
- **文件**: `scripts/hn_comment_analyzer.py`

### 2. AI 内容增强
- **功能**: 不只是翻译，而是真正的深度分析
- **包含**: 技术背景、创新点、应用场景、局限性、商业价值
- **输出**: 结构化的深度解读报告
- **文件**: `scripts/content_enhancer.py`

### 3. RSS 数据源
- **新增源**:
  - News Hacker: https://api.newshacker.me/rss
  - Hacker Podcast: https://hacker-podcast.agi.li/rss.xml
- **功能**: 自动抓取、聚合、去重
- **文件**: `scripts/rss_fetcher.py`

---

## 使用方法

### 1. 安装依赖
```bash
cd scripts
pip install feedparser requests python-dotenv
```

### 2. 配置 API Key
```bash
export OPENAI_API_KEY="your-openai-api-key"
export OPENAI_BASE_URL="https://api.openai.com/v1"  # 可选，用于第三方 API
```

### 3. 运行生成器
```bash
# 生成今天的文章
python daily_intel_enhanced.py

# 生成指定日期的文章
python daily_intel_enhanced.py 2026-02-09
```

### 4. 部署
```bash
git add _posts/2026-02-09-daily-intel-enhanced.md
git commit -m "Add enhanced daily intel"
git push
```

---

## 文件结构

```
daily-intel/
├── scripts/
│   ├── hn_comment_analyzer.py    # HN 评论分析模块
│   ├── content_enhancer.py       # AI 内容增强模块
│   ├── rss_fetcher.py            # RSS 抓取模块
│   ├── daily_intel_enhanced.py   # 主生成器
│   └── requirements.txt          # 依赖列表
└── _posts/
    └── 2026-02-09-daily-intel-enhanced.md
```

---

## 输出示例

```markdown
---
layout: post
title: "每日科技情报 - 2026年02月09日"
...
---

# 📊 每日科技情报 | 2026年02月09日

> 🤖 AI 增强版 | 自动分析 HN 评论 | 内容深度解读 | RSS 聚合

## 🔥 AI 深度分析文章

### 1. LocalGPT - 本地AI助手

#来自 News Hacker

## 📰 核心内容
...

## 🔍 深度解读
...

## 💡 商业价值评估
...

---

## 💬 HN 社区讨论精选

### LocalGPT 讨论

📊 **47 条评论** | 🔥 256 分

**支持观点**:
- ...

**质疑/反对观点**:
- ...

**最有价值的观点**:
- ...
```

---

## 后续优化

- [ ] 添加到 GitHub Actions 自动运行
- [ ] TTS 语音生成
- [ ] Telegram 自动推送
- [ ] 邮件订阅集成
