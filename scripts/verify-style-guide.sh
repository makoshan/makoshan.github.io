#!/bin/bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STRICT=false
SKIP_BUILD=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --strict)
      STRICT=true
      shift
      ;;
    --skip-build)
      SKIP_BUILD=true
      shift
      ;;
    *)
      echo "未知参数: $1"
      echo "用法: $0 [--strict] [--skip-build]"
      exit 1
      ;;
  esac
done

echo "==========================================="
echo "Mako Shan style-guide 合规检查"
echo "==========================================="
echo ""

if [[ "$SKIP_BUILD" == true ]]; then
  echo "[1/3] 跳过生产构建（--skip-build）..."
else
  echo "[1/3] 运行生产构建（包含 YAML/样式规则校验）..."
  "$PROJECT_ROOT/scripts/build-production.sh" --skip-convert
fi

echo "[2/3] 校验关键构建产物..."
required_paths=(
  "_site/index.html"
  "_site/style-guide/index.html"
  "_site/design/index.html"
  "_site/lorem/index.html"
  "_site/static/css/head.css"
  "_site/static/js/script.js"
)

missing=0
for rel in "${required_paths[@]}"; do
  if [[ -f "$PROJECT_ROOT/$rel" ]]; then
    echo "  ✓ $rel"
  else
    echo "  ✗ $rel"
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo ""
  echo "❌ 关键产物缺失，请先修复构建输出"
  exit 1
fi

echo "[3/3] 运行文档缩略图检查..."
if "$PROJECT_ROOT/scripts/check-doc-thumbnails.sh"; then
  echo "  ✓ 缩略图检查通过"
else
  if [[ "$STRICT" == true ]]; then
    echo "  ✗ 缩略图检查未通过（strict 模式下阻塞）"
    exit 1
  fi
  echo "  ⚠ 缩略图检查未通过（不阻塞 style-guide 自动检查）"
fi

optional_paths=(
  "_site/lorem-inline/index.html"
  "_site/lorem-block/index.html"
  "_site/lorem-header/index.html"
  "_site/lorem-transclude/index.html"
)

warned=0
for rel in "${optional_paths[@]}"; do
  if [[ ! -f "$PROJECT_ROOT/$rel" ]]; then
    if [[ "$STRICT" == true ]]; then
      echo "  ✗ 可选测试页缺失（strict 模式下阻塞）: $rel"
    else
      echo "  ⚠ 可选测试页缺失: $rel"
    fi
    warned=1
  fi
done

echo ""
if [[ "$warned" -eq 0 ]]; then
  echo "✅ style-guide 自动检查通过"
else
  if [[ "$STRICT" == true ]]; then
    echo "❌ style-guide 自动检查失败（strict 模式要求可选测试页齐全）"
    exit 1
  fi
  echo "✅ style-guide 自动检查通过（存在可选测试页缺失告警）"
fi
