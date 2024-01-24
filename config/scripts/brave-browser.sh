#!/usr/bin/env bash

set -ouex pipefail

echo "Installing Brave Browser"

# Setup repo
cat << EOF > /etc/yum.repos.d/brave-browser.repo
[brave-browser]
name=Brave Browser
enabled=1
autorefresh=1
baseurl=https://brave-browser-rpm-release.s3.brave.com/\$basearch
EOF

# Import signing key
rpm --import https://brave-browser-rpm-beta.s3.brave.com/brave-core-nightly.asc

# Now let's install the packages.
rpm-ostree install brave-browser

# Clean up the yum repo (updates are baked into new images)
rm /etc/yum.repos.d/brave-browser.repo -f