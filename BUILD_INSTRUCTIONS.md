# Mako Shan 构建指南

本文档说明如何构建和运行 Mako Shan 项目。

---

## 🎯 构建模式

Mako Shan 提供两种构建模式：

### 🔧 开发模式（Development）
**特点**：快速构建，适合日常开发。
- ❌ 禁用链接注解（加快构建速度）
- ✅ 快速预览内容变化
- ✅ 适合文章编辑和调试

**使用场景**：
- 编辑文章内容
- 调整样式和布局
- 快速预览效果

### 🚀 生产模式（Production）
**特点**：完整功能，适合最终发布。
- ✅ **启用链接注解**（绿色数字圆圈）
- ✅ **弹出窗口**显示注释内容
- ✅ **悬浮预览**功能
- ✅ 适合 Newsletter 发布

**使用场景**：
- Newsletter 最终发布
- 正式部署到网站
- 展示完整功能

---

## 前提条件

1.  **Haskell 工具链** (`ghc`, `cabal`)：
    - 通过 [GHCup](https://www.haskell.org/ghcup/) 安装。
    - 验证：
      ```bash
      ghc --version
      cabal --version
      ```

2.  **Python 3**：
    - 用于辅助脚本和本地服务器。
    - 验证：`python3 --version`

3.  **系统依赖**：
    - **macOS**：`brew install imagemagick`
    - **Linux (Debian/Ubuntu)**：`sudo apt-get install libgmp-dev libffi-dev libncurses-dev zlib1g-dev imagemagick`

---

## 🚀 快速开始

### 开发模式（Watch）

运行构建脚本的 watch 模式，以便在更改时自动重建：

```bash
./scripts/build.sh --watch
```

### 生产模式

构建启用所有功能（注解、弹窗）的站点：

```bash
./scripts/build-production.sh
```

---

## 手动构建

如果您更喜欢直接运行 `cabal` 或需要调试构建过程：

1.  进入构建目录：
    ```bash
    cd build
    ```

2.  清理并构建：
    ```bash
    cabal run hakyll -- clean
    cabal run hakyll -- build
    ```
    *注意：多核构建请添加 `+RTS -N -RTS`。*

    不带注解构建（更快）：
    ```bash
    GWERN_ANNOTATIONS=0 cabal run hakyll -- build
    ```

---

## 本地预览

构建完成后，您可以使用包含的 Python 服务器预览站点：

```bash
python3 webserver.py --bind 127.0.0.1 --port 8000 --directory _site
```

在浏览器中打开：[http://localhost:8000/](http://localhost:8000/)

---

## 目录结构

-   `build/`: 构建逻辑 (`site.hs`, `daily-intel.cabal`, 模块)。
-   `static/`: CSS, JS, 字体和模板。
-   `metadata/`: 注释数据库。
-   `scripts/`: 用于构建和维护的辅助脚本。
-   `_site/`: 生成的静态站点（请勿手动编辑）。

---

## 故障排除

### 1. 端口 8000 被占用
如果您看到 `Address already in use`，请终止使用端口 8000 的进程：
```bash
lsof -i :8000
kill -9 <PID>
```

### 2. CSS/JS 缺失
如果站点看起来没有样式：
- 确保构建成功完成。
- 检查 `_site/static/css/head.css` 是否存在。
- 尝试运行清理构建：`./scripts/build-production.sh`

### 3. "does not exist" 错误
如果您看到有关缺失目录（例如 `doc/`）的错误，请创建它们：
```bash
mkdir -p doc
```
