# Daily Intel

> **基于 [Gwern.net](https://github.com/gwern/gwern.net) 的 Fork**  
> 使用 Gwern 的 Hakyll 构建系统和设计理念，定制化用于个人站点与每日资讯发布。

一个以 **Hakyll/Pandoc** 构建的静态站点，用来发布:

- `Daily Intel` 每日资讯 Newsletter
- 文章/随笔（区块链、技术、经济学、统计等）
- docs/资料库（本地文档链接、注解、弹窗预览等能力来自 Gwern.net 风格的构建链路）

站点输出到项目根目录的 `_site/`。

## 快速开始 (WSL)

构建（最直接的方式）:

```bash
cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel/build
cabal update
cabal run hakyll -- build
```

预览（在项目根目录跑，确保能处理无扩展名路由，比如 `/About`）:

```bash
cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel
python3 webserver.py --bind 0.0.0.0 --port 8000 --directory _site
```

更完整的环境依赖与说明见 `BUILD_INSTRUCTIONS.md`。

## 开发/生产构建

开发构建（更快，默认关掉注解相关特性）:

```bash
bash scripts/build.sh
```

开发 watch（边改边编译）:

```bash
bash scripts/build.sh --watch
```

生产构建（启用注解等完整功能）:

```bash
bash scripts/build-production.sh
```

注: 生产模式也可以直接用 `build/site.hs` 的默认值:

```bash
cd build
cabal run hakyll -- clean
cabal run hakyll -- build +RTS -N -RTS
```

## Newsletter 生成

Newsletter 生成与清理说明见 `scripts/NEWSLETTER_QUICKSTART.md`。

典型流程（Windows 侧跑生成器 + WSL 侧编译）:

1. 生成某天的 Newsletter: `python scripts/newsletter/generator.py 2026-02-09`
2. 生产构建: `bash scripts/build-production.sh --skip-convert`
3. 预览: `python3 webserver.py --directory _site`

## 首页与路由

- 首页源文件: `index.page`
- 构建时会生成: `index.generated.page`
- 输出: `_site/index` 与 `_site/index.html`

首页布局（例如“三列一行”）主要通过 `index.page` 内嵌 CSS 控制顶层 `<section class="level1">` 的 flex/grid 行为。

## 目录结构 (概览)

- `build/`: Hakyll 构建工程（`site.hs`, `daily-intel.cabal` 等）
- `static/`: CSS/JS/模板/字体等静态资源
- `_posts/`: 输入的 Markdown（部分会转换成 `.page`）
- `newsletter/`: Newsletter 的 `.page` 源文件与索引
- `docs/`: 本地资料库
- `metadata/`: 注解/弹窗相关数据库与构建产物
- `_site/`: 编译输出目录（部署/预览用）

## 常见问题

- `cabal update` 失败: 通常是 `~/.cabal` 写权限或网络问题，先检查 WSL 用户权限与网络连通性。
- 构建报大量 “Link error … file does not exist”: 这是链接注解扫描阶段的提示，不一定会导致构建失败；真正会失败的错误会在最后以 `[ERROR]`/`CallStack` 形式出现。

