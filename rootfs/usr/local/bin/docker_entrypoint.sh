#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R radarr:radarr /config

# Delete pid if it exists
[[ -e /config/radarr.pid ]] && rm -f /config/radarr.pid

#=========================================================================================

# Start radarr in console mode
exec gosu radarr \
    /Radarr/Radarr -nobrowser -data=/config
