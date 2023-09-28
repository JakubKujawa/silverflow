#!/usr/bin/env bash

set -oue pipefail

# Only run if OS_VERSION is not 39
if grep -qv "39" <<< "$OS_VERSION"; then
    rpm-ostree install \
        kernel-devel-matched \
        kernel-tools \
        /tmp/akmods/rpms/kmods/*openrazer*.rpm \
        /tmp/akmods/rpms/kmods/*openrgb*.rpm
fi