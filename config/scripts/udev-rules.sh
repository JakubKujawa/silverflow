#!/usr/bin/env bash

set -oue pipefail
FILES_ROOT="/tmp/config/files"

wget -O $FILES_ROOT/99-razer.rules 'https://raw.githubusercontent.com/ublue-os/openrazer/master/install_files/udev/99-razer.rules'
wget -O $FILES_ROOT/razer_mount 'https://raw.githubusercontent.com/ublue-os/openrazer/master/install_files/udev/razer_mount'

install -m 0644 "$FILES_ROOT/99-razer.rules" "/usr/lib/udev/rules.d/99-razer.rules"
install -m 0755 "$FILES_ROOT/razer_mount" "/usr/lib/udev/razer_mount"
