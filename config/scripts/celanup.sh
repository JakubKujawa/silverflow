#!/usr/bin/env bash

# This script removes unnecessary files from the original "silverblue-nvidia" image.

# Remove extra repos
ls -l /etc/yum.repos.d/
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo
rm -rf /etc/yum.repos.d/google-chrome.repo 