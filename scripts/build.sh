#!/bin/bash
# Mako Shan 构建脚本 (在 WSL 中运行)
set -e

echo "==================================="
echo "Mako Shan 构建脚本"
echo "==================================="
echo ""

# 获取脚本所在目录的父目录 (项目根目录)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
HAKYLL_CACHE_BIN="$BUILD_DIR/.cache/hakyll/hakyll"

# 参数解析
DATE_ARG=""
SKIP_CONVERT=false
WATCH_MODE=false

require_dependency() {
    local cmd="$1"
    local install_hint="$2"

    if [ -f "$HOME/.ghcup/env" ]; then
        # shellcheck disable=SC1090
        . "$HOME/.ghcup/env"
    fi

    if ! command -v "$cmd" >/dev/null 2>&1; then
        for candidate_dir in "$HOME/.ghcup/bin" "$HOME/.cabal/bin" "$HOME/.local/bin"; do
            if [ -d "$candidate_dir" ] && [ -x "$candidate_dir/$cmd" ] && echo "$PATH" | tr ':' '\n' | grep -qx "$candidate_dir"; then
                continue
            fi
            if [ -d "$candidate_dir" ] && [ -x "$candidate_dir/$cmd" ]; then
                PATH="$candidate_dir:$PATH"
                export PATH
            fi
        done
    fi

    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "错误: 未找到命令 $cmd"
        echo "请先安装依赖后重试："
        echo "  $install_hint"
        echo ""
        echo "安装完成后可通过: $cmd --version 验证"
        exit 1
    fi
}

run_hakyll() {
    local bin=""
    if [ -n "${MAKO_HAKYLL_BIN:-}" ] && [ -x "$MAKO_HAKYLL_BIN" ]; then
        bin="$MAKO_HAKYLL_BIN"
    elif [ -x "$HAKYLL_CACHE_BIN" ]; then
        bin="$HAKYLL_CACHE_BIN"
    else
        bin="$(cd "$BUILD_DIR" && cabal list-bin hakyll 2>/dev/null || true)"
    fi

    if [ -n "$bin" ] && [ -x "$bin" ]; then
        "$bin" "$@"
    else
        (cd "$BUILD_DIR" && cabal run hakyll -- "$@")
    fi
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --date)
            DATE_ARG="$2"
            shift 2
            ;;
        --skip-convert)
            SKIP_CONVERT=true
            shift
            ;;
        --watch)
            WATCH_MODE=true
            shift
            ;;
        *)
            echo "未知参数: $1"
            echo "用法: $0 [--date YYYY-MM-DD] [--skip-convert] [--watch]"
            exit 1
            ;;
    esac
done

# 关键依赖检查
require_dependency cabal "brew install ghc cabal-install  # 或通过 https://www.haskell.org/ghcup/ 安装"

# 1. 转换格式 (如果不跳过)
if [ "$SKIP_CONVERT" = false ]; then
    if [ ! -d "$PROJECT_ROOT/_posts" ]; then
        echo "[1/4] 未检测到 _posts/ 目录，跳过格式转换"
        echo "      （当前仓库不使用 Daily Intel 输入源）"
    else
        CONVERTER="$PROJECT_ROOT/scripts/convert_to_page.py"
        if [ ! -f "$CONVERTER" ]; then
            echo "[1/4] 检测到 _posts/，但未找到转换脚本: $CONVERTER"
            echo "      跳过格式转换（如需转换，请恢复该脚本）"
        else
        echo "[1/4] 转换日报格式..."
        cd "$PROJECT_ROOT"

        if [ -n "$DATE_ARG" ]; then
            POST_FILE="_posts/${DATE_ARG}-daily-intel.md"
            if [ -f "$POST_FILE" ]; then
                python3 "$CONVERTER" "$POST_FILE"
            else
                echo "警告: 文件不存在: $POST_FILE"
                echo "跳过转换步骤"
            fi
        else
            # 转换最新的日报
            LATEST_POST=$(ls -t _posts/*-daily-intel.md 2>/dev/null | head -1)
            if [ -n "$LATEST_POST" ]; then
                echo "转换最新日报: $LATEST_POST"
                python3 "$CONVERTER" "$LATEST_POST"
            else
                echo "警告: 未找到日报文件"
                echo "跳过转换步骤"
            fi
        fi
        fi
    fi
else
    echo "[1/4] 跳过格式转换"
fi

# 2. 进入构建目录
echo "[2/4] 进入构建目录..."
cd "$BUILD_DIR"

# 3. 编译或 watch
if [ "$WATCH_MODE" = true ]; then
    echo "[3/4] 启动 watch 模式..."
    echo "提示: 按 Ctrl+C 停止"
    echo ""
    
    GWERN_ANNOTATIONS=0 \
    GWERN_EXTERNAL_ANNOTATIONS=0 \
    GWERN_WRITE_MISSING_ANNOTATIONS=0 \
    GWERN_LINK_ANNOTATIONS=0 \
    GWERN_LINK_SIZES=0 \
    run_hakyll watch
else
    echo "[3/4] 编译网站..."
    
    # 清理
    run_hakyll clean
    
    # 构建
    GWERN_ANNOTATIONS=0 \
    GWERN_EXTERNAL_ANNOTATIONS=0 \
    GWERN_WRITE_MISSING_ANNOTATIONS=0 \
    GWERN_LINK_ANNOTATIONS=0 \
    GWERN_LINK_SIZES=0 \
    run_hakyll build
    
    # 4. 验证
    echo "[4/4] 验证构建..."
    cd "$PROJECT_ROOT"
    
    if [ -f "_site/static/css/head.css" ]; then
        echo "✓ CSS 已生成"
    else
        echo "✗ CSS 缺失"
    fi
    
    if [ -f "_site/static/js/script.js" ]; then
        echo "✓ JS 已生成"
    else
        echo "✗ JS 缺失"
    fi
    
    # 检查生成的页面
    if [ -n "$DATE_ARG" ]; then
        PAGE_FILE="_site/${DATE_ARG}-daily-intel"
        if [ -f "$PAGE_FILE" ] || [ -f "${PAGE_FILE}.html" ]; then
            echo "✓ 页面已生成"
        else
            echo "✗ 页面缺失: $PAGE_FILE"
        fi
    fi
    
    echo ""
    echo "✅ 构建完成！"
    echo ""
    echo "预览网站:"
    echo "  python3 webserver.py --bind 0.0.0.0 --port 8000 --directory _site"
    echo ""
    echo "访问:"
    echo "  http://localhost:8000/"

    # WSL: hostname -I；macOS: ipconfig getifaddr en0
    IP_ADDR="$(hostname -I 2>/dev/null | awk '{print $1}')"
    if [ -z "$IP_ADDR" ] && command -v ipconfig >/dev/null 2>&1; then
        IP_ADDR="$(ipconfig getifaddr en0 2>/dev/null || true)"
    fi
    if [ -n "$IP_ADDR" ]; then
        echo "  http://$IP_ADDR:8000/"
    fi
fi
