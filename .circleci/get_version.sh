#!/usr/bin/env bash

set -euo pipefail

# Application version
APP_VERSION="$(curl -sSL --retry 5 --retry-delay 2 "https://radarr.servarr.com/v1/update/master/changes" | jq -r '.[0].version')"
echo "$APP_VERSION"
