#!/usr/bin/env bash
set -oue pipefail

get_yaml_array ENTRIES '.entries[]' "$1"

if [[ ${#ENTRIES[@]} -gt 0 ]]; then
    echo "Removing desktop entries..."
    for entry in "${ENTRIES[@]}"; do
        entry="${entry%\"}"
        entry="${entry#\"}"
        entry=$(printf "%q" "$entry")

        desktop_file="/usr/share/applications/${entry}.desktop"

        if [[ -f "$desktop_file" ]]; then
            rm -f "$desktop_file"
            echo "Removed: $entry"
        else
            echo "Not found: $entry"
        fi
    done
fi

get_yaml_array REPOS '.repos[]' "$1"

if [[ ${#REPOS[@]} -gt 0 ]]; then
    echo "Removing repositories..."
    for repo in "${REPOS[@]}"; do
        repo="${repo%\"}"
        repo="${repo#\"}"
        repo=$(printf "%q" "$repo")

        repo_file="/etc/yum.repos.d/${repo}.repo"

        if [[ -f "$repo_file" ]]; then
            rm -f "$repo_file"
            echo "Removed: $repo_file"
        else
            echo "Not found: $repo_file"
        fi
    done
fi
