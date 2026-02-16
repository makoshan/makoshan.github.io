#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR/build"

echo "[1/2] Clean..."
cabal run hakyll -- clean

echo "[2/2] Build..."
cabal run hakyll -- build +RTS -N1 -RTS

echo "Done."
