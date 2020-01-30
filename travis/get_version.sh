#!/usr/bin/env bash

set -euo pipefail

# Output traefik version from github:traefik releases
echo "$(curl -fsSL --retry 5 --retry-delay 2 https://api.github.com/repos/Radarr/Radarr/releases | jq -r .['0'].tag_name | cut -c 2-)"
