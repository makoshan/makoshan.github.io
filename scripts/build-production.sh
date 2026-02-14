#!/bin/bash
# Daily Intel 生产构建脚本（启用所有功能，包括注解）
# 用于最终发布和 Newsletter 生成
set -e

echo "==========================================="
echo "Daily Intel 生产构建（启用注解功能）"
echo "==========================================="
echo ""

# 获取脚本所在目录的父目录 (项目根目录)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"

# 参数解析
DATE_ARG=""
SKIP_CONVERT=false

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
        *)
            echo "未知参数: $1"
            echo "用法: $0 [--date YYYY-MM-DD] [--skip-convert]"
            exit 1
            ;;
    esac
done

# 1. 转换格式 (如果不跳过)
if [ "$SKIP_CONVERT" = false ]; then
    CONVERTER="$PROJECT_ROOT/scripts/convert_to_page.py"
    if [ ! -f "$CONVERTER" ]; then
        echo "[1/4] 未找到转换脚本: $CONVERTER"
        echo "跳过格式转换（可用 --skip-convert 显式跳过）"
    elif [ ! -d "$PROJECT_ROOT/_posts" ]; then
        echo "[1/4] 未找到 _posts/ 目录"
        echo "跳过格式转换（当前仓库可能不包含 Markdown 输入源）"
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
else
    echo "[1/4] 跳过格式转换"
fi

#2. 进入构建目录
echo "[2/4] 进入构建目录..."
cd "$BUILD_DIR"

# 3. 生产构建（启用注解功能）
echo "[3/4] 生产构建（注解功能已启用）..."
echo "  ✓ 链接注解弹出窗口"
echo "  ✓ 绿色数字圆圈指示"
echo "  ✓ 悬浮预览功能"
echo ""

# 清理
cabal run hakyll -- clean

# 构建 - 使用默认的启用状态（site.hs 中已设置 fromMaybe "1"）
# 不设置环境变量，使用默认值
cabal run hakyll -- build +RTS -N -RTS

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
echo "✅ 生产构建完成！（注解功能已启用）"
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
echo ""
echo "注: 链接注解功能已启用，查看效果请访问有注解的页面"
