# Newsletter 使用指南

## 生成 Newsletter

```powershell
# 在项目根目录执行
cd C:\Users\ROG\.openclaw\workspace\projects\daily-intel

# 生成今天的 Newsletter
python scripts\newsletter\generator.py

# 生成指定日期
python scripts\newsletter\generator.py 2026-02-09
```

## 清理旧文件

```powershell
# 在 scripts 目录执行清理脚本
cd scripts
powershell -ExecutionPolicy Bypass .\cleanup.ps1
```

## 编译和预览

```bash
# 编译（WSL）
bash scripts/build.sh --skip-convert

# 或在 Windows 直接编译
cd build
cabal run hakyll -- clean
cabal run hakyll -- build
```

## 生成的文件位置

- Newsletter: `newsletter/2026/newsletter-2026-02-09.page`
- 索引页: `newsletter/index.page`
- 编译后: `_site/2026/newsletter-2026-02-09`

## 新旧对比

### 之前
- 46 个文件分散在 scripts/ 目录
- 多个重复的 Python 脚本
- 大量冗余文档

### 之后
- Newsletter 模块集中在 `scripts/newsletter/`
- 4 个核心文件（generator.py, rss_fetcher.py, requirements.txt, README.md）
- 简洁清晰，易于维护
