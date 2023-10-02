#!/usr/bin/env bash

set -oue pipefail

getent group plugdev >/dev/null || groupadd -r plugdev
