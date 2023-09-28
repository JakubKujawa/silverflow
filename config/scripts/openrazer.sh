#!/usr/bin/env bash

set -oue pipefail

cp /tmp/config/files/usr/lib/udev/rules.d/99-razer.rules /usr/lib/udev/rules.d/99-razer.rules
cp /tmp/config/files/usr/lib/udev/razer_mount /usr/lib/udev/razer_mount

getent group plugdev >/dev/null || groupadd -r plugdev