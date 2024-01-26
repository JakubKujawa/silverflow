#!/usr/bin/env bash

set -euoe pipefail

FILES_ROOT="/tmp/config/files"

wget -O $FILES_ROOT/docker-compose 'https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64'
install -c -m 0755 "$FILES_ROOT/docker-compose" "/usr/bin/docker-compose"
