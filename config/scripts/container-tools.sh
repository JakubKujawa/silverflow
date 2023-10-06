#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail
FILES_ROOT="/tmp/config/files"

wget -O $FILES_ROOT/docker-compose 'https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64'
install -c -m 0755 "$FILES_ROOT/docker-compose" "/usr/bin/docker-compose"
