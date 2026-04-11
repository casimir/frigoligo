#!/bin/sh
# Build Mermaid bundle for the article WebView.
# Re-run when upgrading mermaid.
#
# Usage: sh scripts/build-mermaid.sh
set -e

DEST="assets/www/scripts/mermaid"
MERMAID_VERSION="11.4.1"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

cd "$TMPDIR"
npm init -y > /dev/null
npm install "mermaid@$MERMAID_VERSION" > /dev/null

SRC="$TMPDIR/node_modules/mermaid/dist"

mkdir -p "$OLDPWD/$DEST"
cp "$SRC/mermaid.min.js" "$OLDPWD/$DEST/mermaid.min.js"
cp "$TMPDIR/node_modules/mermaid/LICENSE" "$OLDPWD/$DEST/LICENSE.txt"

echo "Mermaid $MERMAID_VERSION assets written to $DEST"
