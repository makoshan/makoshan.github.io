# Newsletter 生成器

每日科技情报 Newsletter 自动生成工具。从 RSS 源抓取资讯，生成 Hakyll .page 格式文件。

## 快速开始

### 1. 安装依赖

```bash
cd scripts/newsletter
pip install -r requirements.txt
```

### 2. 生成 Newsletter

```bash
# 生成今天的 Newsletter
python generator.py

# 生成指定日期的 Newsletter
python generator.py 2026-02-09
```

### 3. 编译网站

```bash
# 返回项目根目录
cd ../..

# 编译（WSL）
bash scripts/build.sh --skip-convert
```

### 4. 预览

```bash
# 启动本地服务器
python webserver.py --port 8000 --directory _site

# 浏览器访问
http://localhost:8000/newsletter/
```

## 输出文件

生成的文件按年份组织：

```
newsletter/
├── 2026/
│   └── newsletter-2026-02-09.page
├── 2025/
│   └── ...
├── index.page          # 自动更新的总索引
└── topics.page         # （未实现）主题索引
```

## 数据源

RSS 源配置在 `rss_fetcher.py` 中：

- **News Hacker** - https://api.newshacker.me/rss
- **Hacker Podcast** - https://hacker-podcast.agi.li/rss.xml

### 添加新数据源

编辑 `rss_fetcher.py`：

```python
self.sources = {
    "new_source": {
        "name": "Source Name",
        "url": "https://example.com/rss",
        "category": "类别"
    }
}
```

## 文件说明

- **`generator.py`** - Newsletter 生成器（可直接运行）
- **`rss_fetcher.py`** - RSS 数据抓取模块
- **`requirements.txt`** - Python 依赖

## 故障排除

### RSS 抓取失败

检查网络连接和 RSS URL 是否可访问。

### 编译失败

```bash
# 清理重建
cd build
cabal run hakyll -- clean
cabal run hakyll -- build
```

---

*简化版本 - 保持简单，易于维护*
