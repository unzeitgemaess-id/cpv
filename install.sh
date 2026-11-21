#!/usr/bin/env bash
# Pasang cpv + mvv.
#   ./install.sh            -> ke ~/.local/bin (tanpa sudo)
#   sudo ./install.sh --system -> ke /usr/local/bin
# Bisa juga langsung dari GitHub:
#   curl -fsSL https://raw.githubusercontent.com/unzeitgemaess-id/cpv/main/install.sh | bash
set -euo pipefail

REPO="unzeitgemaess-id/cpv"
BRANCH="main"
PREFIX="${HOME}/.local/bin"
[ "${1:-}" = "--system" ] && PREFIX="/usr/local/bin"

command -v python3 >/dev/null || { echo "python3 tidak ditemukan, pasang dulu: sudo apt install python3"; exit 1; }

mkdir -p "$PREFIX"
src="${BASH_SOURCE[0]:-}"
if [ -n "$src" ] && [ -f "$(dirname "$src")/cpv" ]; then
    install -m 755 "$(dirname "$src")/cpv" "$PREFIX/cpv"
else
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/cpv" -o "$PREFIX/cpv"
    chmod 755 "$PREFIX/cpv"
fi
ln -sf "$PREFIX/cpv" "$PREFIX/mvv"

echo "Terpasang: $PREFIX/cpv dan $PREFIX/mvv"
case ":$PATH:" in
    *":$PREFIX:"*) ;;
    *) echo "Catatan: $PREFIX belum ada di PATH. Jalankan:"
       echo "  echo 'export PATH=\"$PREFIX:\$PATH\"' >> ~/.bashrc && source ~/.bashrc" ;;
esac
