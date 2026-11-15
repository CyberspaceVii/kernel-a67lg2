#!/usr/bin/env bash
# Build the SUSFS Config module zip. The bundled ksu_susfs must match the kernel's susfs version.
set -euo pipefail
cd "$(dirname "$0")"
TOOL=work/src/susfs4ksu/ksu_susfs/libs/arm64-v8a/ksu_susfs
[ -f "$TOOL" ] || { echo "build the tool first (ndk-build in work/src/susfs4ksu/ksu_susfs)"; exit 1; }
cp "$TOOL" susfs-module/tools/ksu_susfs_arm64
mkdir -p out; rm -f out/susfs-config-a67lg2.zip
(cd susfs-module && zip -qr9 ../out/susfs-config-a67lg2.zip . -x 'fake_bootconfig.txt')
echo "out/susfs-config-a67lg2.zip"; unzip -l out/susfs-config-a67lg2.zip
