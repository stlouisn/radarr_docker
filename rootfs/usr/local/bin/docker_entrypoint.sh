#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R radarr:radarr /config

# Delete PID if it exists
if
    [ -e "/config/radarr.pid" ]
then
    rm -f /config/radarr.pid
fi

#=========================================================================================

# Start radarr in console mode
exec gosu radarr \
    /Radarr/Radarr -nobrowser -data=/config
