#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

rpm-ostree install \
    kernel-devel-matched \
    /tmp/rpms/kmods/*openrazer*.rpm \
    /tmp/rpms/kmods/*v4l2loopback*.rpm \
    /tmp/rpms/kmods/*ryzen-smu*.rpm
