#!/usr/bin/bash
shopt -s nullglob

# Flatpak Firefox
for firefox_gnome_theme in "$HOME/.var/app/org.mozilla.firefox/.mozilla/firefox/"*".default"*"/chrome/firefox-gnome-theme/"; do
    if [ -d "$firefox_gnome_theme" ]; then
        cd "$firefox_gnome_theme" || exit
        git pull
    fi
done
