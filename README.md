# cpv & mvv

`cp` dan `mv` versi aman-eject untuk Linux. Satu file Python, tanpa dependensi.

- **`cpv`** menyalin berkas/folder (seperti `cp -r`).
- **`mvv`** memindah berkas/folder (seperti `mv`). Sumber baru dihapus setelah data benar-benar tertulis di tujuan.

Kenapa ada: setelah menyalin ke flashdisk, `cp` terlihat selesai padahal data masih antre di RAM, lalu eject gagal dengan "perangkat sibuk". `cpv` dan `mvv` memaksa data tertulis (`fsync` + `sync`) sebelum selesai, jadi begitu progres 100% flashdisk langsung aman dicabut.

> Nama `cpv` dipilih karena `cpp` sudah dipakai C preprocessor bawaan gcc.

## Pasang

```bash
git clone https://github.com/unzeitgemaess-id/cpv.git && cd cpv && ./install.sh
```

Atau langsung tanpa clone:

```bash
curl -fsSL https://raw.githubusercontent.com/unzeitgemaess-id/cpv/main/install.sh | bash
```

Secara bawaan terpasang di `~/.local/bin`. Untuk seluruh sistem: `sudo ./install.sh --system`.
Hapus dengan `./uninstall.sh`.

## Pakai

```bash
cpv film.mkv subs.srt /run/media/$USER/FLASHDISK/
mvv folder/ /run/media/$USER/FLASHDISK/
cpv -e folder/ /run/media/$USER/FLASHDISK/   # sekalian unmount + power-off
```

| Opsi | Fungsi |
|------|--------|
| `-e`, `--eject` | unmount + power-off perangkat tujuan setelah selesai (hanya untuk `/media`, `/run/media`, `/mnt`) |
| `-n`, `--no-clobber` | jangan timpa berkas yang sudah ada |
| `-q`, `--quiet` | tanpa indikator progres |

## Cara kerja

- Salinan ditulis ke berkas sementara `*.cpp-part`, dicek ukurannya, lalu di-rename atomik. Kalau dibatalkan (Ctrl+C), berkas parsial dibersihkan dan sumber tidak disentuh.
- `fdatasync` tiap 16 MB supaya bar progres mengikuti kecepatan flashdisk yang sebenarnya.
- `mvv` di filesystem yang sama hanya `rename` (instan). Lintas filesystem: salin, verifikasi, baru hapus sumber.
- Progres: bar braille hijau, persen, kecepatan, sisa waktu, jumlah berkas. Butuh terminal truecolor.

## Lisensi

MIT
