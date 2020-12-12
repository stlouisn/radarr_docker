#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R radarr:radarr /config

# Delete pid if it exists
[[ -e /config/radarr.pid ]] && rm -f /config/radarr.pid

#=========================================================================================

# Workaround for ICU requirements - disable globalization
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Start radarr in console mode
#exec gosu radarr \
#    /usr/bin/mono --debug \
#    /Radarr/Radarr.exe -nobrowser -data=/config
exec gosu radarr \
    /Radarr/Radarr -nobrowser -data=/config
