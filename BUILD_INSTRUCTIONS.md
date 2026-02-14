# Daily Intel 编译指南（WSL 环境）

本文档说明如何在 WSL (Windows Subsystem for Linux) 环境中编译和运行 Daily Intel 项目。

---

## 🎯 构建模式说明

Daily Intel 提供两种构建模式：

### 🔧 开发模式（Development）
**特点**：快速构建，适合日常开发
- ❌ 禁用链接注解（加快构建速度）
- ✅ 快速预览内容变化
- ✅ 适合文章编辑和调试

**使用场景**：
- 编辑文章内容
- 调整样式和布局
- 快速预览效果

### 🚀 生产模式（Production）
**特点**：完整功能，适合最终发布
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

### WSL 环境

1.  已安装 WSL (Ubuntu 推荐)
2.  确认 WSL 已配置 `ghcup`, `cabal`, `ghc`:
    ```bash
    which ghcup cabal ghc
    ```
    
    如未安装，参考 [GHCup 官方文档](https://www.haskell.org/ghcup/) 安装 Haskell 工具链。

3.  确认 Python 3:
    ```bash
    python3 --version
    ```

---

## 🚀 快速开始

### 开发模式（Development）

**在 WSL 中执行**:
1.  打开 WSL:
    ```bash
    wsl
    ```

2.  安装 Haskell 工具链 (如果尚未安装):
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    source ~/.ghcup/env
    ```

3.  安装系统依赖:
    ```bash
    sudo apt-get update
    sudo apt-get install -y libgmp-dev libffi-dev libncurses-dev zlib1g-dev imagemagick
    ```

## 构建站点

1.  导航到项目目录:
    ```bash
    # 注意: 请根据您在 WSL 中的实际路径调整 (例如 /mnt/c/Users/...)
    cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel/build
    ```

2.  初始化并构建:
    ```bash
    cabal update
    cabal run hakyll -- build
    ```

    *注意: 首次构建需要下载和编译依赖项，可能需要一些时间。*



  cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel/build
  cabal run hakyll -- rebuild +RTS -N -RTS

  或显式 clean 再 build：

  cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel/build
  cabal run hakyll -- clean
  cabal run hakyll -- build +RTS -N -RTS

  你可以用这个快速确认输出数量是否恢复正常：

  cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel                                                                         
  find _site -maxdepth 1 -type f | wc -l     


3.  运行开发服务器（禁用注解以加快构建）:
    ```bash
    # 方式1: 使用 Makefile（推荐）
    make watch
    
    # 方式2: 使用 shell 脚本
    ./scripts/build.sh --watch
    ```

### 生产模式（Production）⭐

**用于 Newsletter 发布和最终部署**：

```bash
cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel

# 方式1: 使用 Makefile（推荐）
make production

# 方式2: 使用 shell 脚本
./scripts/build-production.sh

# 方式3: 直接使用 cabal（依赖 site.hs 默认设置）
cd build
cabal run hakyll -- build +RTS -N -RTS
```

**生产构建后验证**：
```bash
# 启动预览服务器
python3 webserver.py --bind 0.0.0.0 --port 8000 --directory _site
```

然后访问有注解的页面：
- `http://localhost:8000/resorter` - 查看绿色数字圆圈
- `http://localhost:8000/Bitcoin%20is%20Worse%20is%20Better` - 点击圆圈测试弹窗

---

4.  在 **Windows 浏览器** 打开（假设 WSL IP 为 `172.x.x.x`）://127.0.0.1:8000`
    - Windows 端 (如果 localhost 不通): 使用 WSL IP 访问
      ```bash
      hostname -I | awk '{print $1}'
      ```
      然后在 Windows 浏览器打开: `http://<WSL_IP>:8000/`

5.  只构建并用静态服务器预览 (更接近最终部署形态):
    ```bash
    cabal run hakyll -- clean
    cabal run hakyll -- build

    # 用项目自带 webserver.py 预览（推荐；可正确渲染无扩展名页面如 /About）
    python3 ../webserver.py --bind 0.0.0.0 --port 8000 --directory ../_site
    ```
    然后在 Windows 浏览器打开: `http://<WSL_IP>:8000/` 或 `http://localhost:8000/`。
    
    **注**: 链接注解和弹出功能现在默认开启。

## 目录结构

-   `build/`: 包含构建逻辑 (`site.hs`, `daily-intel.cabal`)。
-   `static/`: 包含 CSS, JS, 字体和模板。
-   `metadata/`: 包含注释数据库。
-   `about.md`: 展示设计功能的示例页面。

## 样式与静态资源 (Gwern.net 1:1 复刻关键点)

### 1. 实际加载的是哪套 CSS/JS

页面最终加载的 CSS/JS 入口由 `static/include/inlined-asset-links.html` 决定。

当前约定的稳定入口文件是:
- `static/css/head.css`
- `static/css/style.css`
- `static/js/head.js`
- `static/js/script.js`

这些文件用于屏蔽 gwern.net 上“版本化文件名”(如 `head-VERSIONED.css`, `script-GENERATED.js`)带来的路径差异，方便在 HTML 中引用固定路径。

### 2. 为什么页面会“没有 CSS”

常见原因是只构建了单个页面，但 `_site/` 里没有同步静态资源。

当前 `build/site.hs` 已强制在编译时复制 `static/**` 到 `_site/static/**`，即使只编译单个页面也应该有样式。

快速自检:
```bash
test -f ../_site/static/css/head.css && echo "ok: head.css"
test -f ../_site/static/js/script.js && echo "ok: script.js"
```

### 3. 资源来源与同步策略

项目里保留了 `gwern.net/` 目录作为上游参考/镜像，但运行时不应该出现 `/gwern.net/...` 路径。

运行时资源统一从 `daily-intel/static/` 提供，并由 Hakyll 复制到 `_site/static/`。

## 故障排除与常见坑

### 1. 端口 8000 被占用
如果您看到 `Network.Socket.bind: resource busy`，说明有另一个进程正在使用 8000 端口。
```bash
# 查找进程
lsof -i :8000
# 终止进程 (替换 PID)
kill -9 <PID>
```

### 2. 跨设备链接错误 (WSL)
如果您看到 `renameFile:renamePath:rename ... unsupported operation (Invalid cross-device link)`，这是因为 Haskell 的 `renameFile` 在 WSL 挂载点 (`/tmp` vs `/mnt/c`) 之间操作时的问题。
**修复**: `Utils.hs` 文件已打补丁，使用 `copyFile` + `removeFile` 代替 `renameFile`。请确保您使用的是最新版本的 `build/Utils.hs`。

### 3. 文件路径问题
配置 `Config/Misc.hs` 已更新为使用绝对路径来检查项目根目录 `Config.Misc.root = unsafePerformIO $ makeAbsolute ".."`。

### 4. 大小写敏感性
主构建文件已从 `hakyll.hs` 重命名为 `site.hs`，以避免在不区分大小写的文件系统 (Windows/macOS) 上与 `Hakyll` 模块发生冲突。请始终运行:
```bash
cabal run site.hs -- watch
# 或者直接运行
cabal run hakyll -- watch
```
(可执行文件名称 `hakyll` 在 `daily-intel.cabal` 中定义并映射到 `site.hs`)。

### 5. 缺失目录
如果您遇到类似 `doc/` 目录的 `does not exist` 错误，请手动创建它们:
```bash
mkdir -p ../doc
```

### 6. 脚本行尾是 CRLF (WSL 报 `python\r` / `bad interpreter`)
如果您在 WSL 里执行脚本时看到类似:
- `/usr/bin/env: ‘python\r’: No such file or directory`
- `bad interpreter: No such file or directory`

通常是脚本被 Windows 写成了 CRLF 行尾。可用以下任一方式修复:
```bash
# 需要安装 dos2unix
sudo apt-get install -y dos2unix
dos2unix static/build/*

# 或不安装额外工具 (sed)
sed -i 's/\r$//' static/build/*
```

### 6. 代理导致 502/连接失败
如果 `curl` 或浏览器走代理导致本地访问失败:
```bash
curl --noproxy '*' -I http://127.0.0.1:8000/
```
或在 WSL 中设置:
```bash
export NO_PROXY=localhost,127.0.0.1,::1
```

Windows 侧如果开启了“系统代理”，需要把本地地址加入代理例外列表:
- `localhost`
- `127.0.0.1`
- `::1`
- `<WSL_IP>` (如果用 WSL IP 访问)

### 7. 首页显示目录列表
如果访问 `/` 时显示目录列表，说明没有生成 `index.html`，请执行:
```bash
cabal run hakyll -- build
```
并确认你启动静态服务器时 `--directory` 指向的是生成目录 `../_site/`（而不是项目根目录）。

---

## 🔍 验证链接注解功能

生产构建（`make production`）完成后，按以下步骤验证链接注解功能：

### 1. 访问测试页面

在浏览器打开以下页面（包含注解）：

| 页面 | URL | 查看内容 |
|------|-----|----------|
| Resorter | `http://localhost:8000/resorter` | 绿色数字圆圈 |
| Bitcoin | `http://localhost:8000/Bitcoin%20is%20Worse%20is%20Better` | 链接注解弹窗 |
| Melatonin | `http://localhost:8000/Melatonin` | 悬浮预览 |

### 2. 检查功能

- ✅ **绿色圆圈**：链接旁边应该显示绿色数字（如 `①` `②`）
- ✅ **点击测试**：点击圆圈应该弹出注解窗口
- ✅ **悬浮测试**：鼠标悬停在链接上应该显示预览

**参考示例**: [Gwern.net/resorter](https://gwern.net/resorter#source-code)

---

## ❓ 注解功能常见问题

### Q1: 为什么开发模式禁用注解？

**A**: 注解功能需要额外的处理时间。开发时频繁重建，禁用注解可以大幅加快构建速度（从分钟级降到秒级）。

### Q2: 如何确认注解功能已启用？

**A**: 
1. 检查构建日志，确认没有设置 `GWERN_ANNOTATIONS=0`
2. 访问 `/resorter` 页面，查看是否有绿色数字圆圈
3. 点击圆圈，检查是否弹出注解窗口

### Q3: 注解功能不工作怎么办？

**A**: 检查以下几点：
1. 确认使用 `make production` 而非 `make build`
2. 清理重建：`cd build && cabal run hakyll -- clean && cd .. && make production`
3. 检查 `_site/static/js/` 是否有相关 JavaScript 文件
4. 检查浏览器控制台是否有错误

### Q4: 构建时出现 "Warning: no thumbnail-text alt text" 怎么办？

**A**: 这是正常的警告信息，表示某些链接没有定义缩略图替代文本。**不影响**注解功能和网站正常显示，可以忽略。

### Q5: 如何只禁用注解，但使用正常构建？

**A**: 
```bash
GWERN_ANNOTATIONS=0 \
GWERN_LINK_ANNOTATIONS=0 \
cabal run hakyll -- build +RTS -N -RTS
```

---

## 本地预览方式 (Windows 浏览器)

### 方式 A: 直接用 Hakyll `watch` (WSL 内启动)

优点: 修改后自动重建。

如果 Windows 访问 `http://localhost:8000/` 出现 `ERR_CONNECTION_REFUSED` 或 `502`:
- 先用 WSL 侧验证: `curl --noproxy '*' -I http://127.0.0.1:8000/`
- 再改用 WSL IP: `http://<WSL_IP>:8000/`
- 确保 Windows 代理例外已配置 (见上文)

### 方式 B: 构建 `_site/` 后用静态服务器 (WSL 或 Windows 启动)

WSL 启动并允许 Windows 用 WSL IP 访问（推荐用项目自带 `webserver.py`，否则 Python 自带的 `http.server` 可能会把无扩展名页面当附件下载）:
```bash
cd /mnt/c/Users/ROG/.openclaw/workspace/projects/daily-intel
python3 webserver.py --bind 0.0.0.0 --port 8000 --directory _site
```
Windows 浏览器打开: `http://<WSL_IP>:8000/`

Windows 启动 (PowerShell):
```powershell
cd C:\Users\ROG\.openclaw\workspace\projects\daily-intel
python webserver.py --bind 127.0.0.1 --port 8000 --directory _site
```
Windows 浏览器打开: `http://localhost:8000/`

注意:
- `http://0.0.0.0:8000/` 不是可访问的浏览器地址，只用于“绑定监听地址”，浏览器应使用 `localhost` 或实际 IP。
