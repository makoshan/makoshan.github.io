#!/usr/bin/env bash
# 检查 metadata/auto.gtx 中所有 /doc/ 图片路径在本地是否存在
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AUTO_GTX="$ROOT_DIR/metadata/auto.gtx"

if [[ ! -f "$AUTO_GTX" ]]; then
  echo "❌ 找不到文件: $AUTO_GTX"
  exit 1
fi

temp_file="$(mktemp)"
cleanup() { rm -f "$temp_file"; }
trap cleanup EXIT

# 抽取可能的图片路径，保留 /doc/ 开头并以常见图片后缀结尾
if ! grep -oE "/doc/[^\"' )>]+\\.(png|jpe?g|gif|webp|svg|bmp|ico|avif)" "$AUTO_GTX" \
  | sed -E 's/[?#].*$//' \
  | sed -E 's#%2[fF]#/#g' \
  | sort -u > "$temp_file"; then
  echo "✅ metadata/auto.gtx 中未发现可匹配的 /doc 图片路径（可能内容没有以 /doc/...jpg 等形式出现）"
  exit 0
fi

missing=0
while IFS= read -r rel; do
  [[ -z "$rel" ]] && continue
  abs="$ROOT_DIR/${rel#/}"
  if [[ ! -f "$abs" ]]; then
    echo "❌ 缺失: $rel"
    missing=1
  fi
done < "$temp_file"

if [[ "$missing" -eq 0 ]]; then
  echo "✅ metadata/auto.gtx 中 /doc 图片路径检查通过：未发现缺失文件"
  exit 0
else
  echo "⚠️ 发现缺失文件（上面已列出）"
  exit 1
fi
