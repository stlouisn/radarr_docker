#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R www-data:www-data /config

# Delete pid if it exists
[[ -e /config/radarr.pid ]] && rm -f /config/radarr.pid

#=========================================================================================

# Start radarr in console mode
exec gosu www-data \
    /usr/bin/mono --debug \
    /opt/Radarr/Radarr.exe -nobrowser -data=/config
