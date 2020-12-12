#!/usr/bin/env bash

set -euo pipefail

# Output radarr version from github:radarr releases
echo "$(curl -fsSL --retry 5 --retry-delay 2 https://api.github.com/repos/Radarr/Radarr/releases | jq -r .['0'].tag_name | tr -d v)"
