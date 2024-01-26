#!/usr/bin/env bash

set -euo pipefail

FILES_ROOT="/tmp/config/files"

wget -O "${FILES_ROOT}/Bibata-Modern-Ice.tar.xz" https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Ice.tar.xz
wget -O "${FILES_ROOT}/Bibata-Modern-Classic.tar.xz" https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Classic.tar.xz

cd "${FILES_ROOT}" || exit

for f in *.tar.xz; do
    directory_name=$(basename "${f}" .tar.xz)

    echo "Unpacking ${f}"
    tar -xf "${f}"

    echo "Copying ${directory_name} to /usr/share/icons/"
    cp -r "${directory_name}" "/usr/share/icons/"
done
