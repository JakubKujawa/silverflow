#!/usr/bin/env bash

set -oue pipefail

FILES_ROOT="/tmp/config/files"

wget -O "${FILES_ROOT}/Bibata-Modern-Ice.tar.xz" https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Ice.tar.xz
wget -O "${FILES_ROOT}/Bibata-Modern-Classic.tar.xz" https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Classic.tar.xz

cd "${FILES_ROOT}" || exit

for f in *.tar.xz; do
    echo "Unpacking ${f}"
    tar -xf "${f}"
done

cp -r Bibata-Modern-Classic "/usr/share/icons/"
cp -r Bibata-Modern-Ice "/usr/share/icons/"
