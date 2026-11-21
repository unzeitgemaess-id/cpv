#!/usr/bin/env bash
# Hapus cpv + mvv dari ~/.local/bin (dan /usr/local/bin kalau dijalankan dengan sudo).
for d in "$HOME/.local/bin" /usr/local/bin; do
    for f in cpv mvv; do
        if [ -e "$d/$f" ] || [ -L "$d/$f" ]; then rm -f "$d/$f" && echo "Dihapus: $d/$f"; fi
    done
done
