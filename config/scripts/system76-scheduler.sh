#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

wget "https://copr.fedorainfracloud.org/coprs/kylegospo/system76-scheduler/repo/fedora-$(rpm -E %fedora)/kylegospo-system76-scheduler-fedora-$(rpm -E %fedora).repo" \
    -O /etc/yum.repos.d/_copr_kylegospo_system76_scheduler_fedora.repo

wget "https://copr.fedorainfracloud.org/coprs/szydell/system76/repo/fedora-$(rpm -E %fedora)/szydell-system76-fedora-$(rpm -E %fedora).repo" \
    -O /etc/yum.repos.d/_copr_szydell_system76_fedora.repo

if rpm -qa | grep power-profiles-daemon ; then
    rpm-ostree override remove power-profiles-daemon --install=system76-scheduler --install=system76-power \
    --install=gnome-shell-extension-system76-scheduler --install=system76-dkms --install=system76-acpi-dkms
else
    rpm-ostree install system76-scheduler system76-power gnome-shell-extension-system76-scheduler
fi

systemctl enable com.system76.Scheduler.service
systemctl enable com.system76.PowerDaemon.service
systemctl enable system76-power-wake.service

mkdir -p /usr/etc/system76-scheduler
wget https://raw.githubusercontent.com/ublue-os/bazzite/main/system_files/desktop/shared/usr/etc/system76-scheduler/config.kdl -O /usr/etc/system76-scheduler/config.kdl

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo_system76_scheduler_fedora.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_szydell_system76_fedora.repo
