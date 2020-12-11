#FROM stlouisn/mono:latest
FROM stlouisn/ubuntu:latest

COPY rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Create radarr group
    groupadd \
        --system \
        --gid 10000 \
        radarr && \

    # Create radarr user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment radarr \
        --gid 10000 \
        --uid 10000 \
        radarr && \

    # Update apt-cache
    apt-get update && \

    # Install sqlite
    apt-get install -y --no-install-recommends \
        sqlite3 && \

    # Install mediainfo
    apt-get install -y --no-install-recommends \
        mediainfo && \

    # Install chromaprint/fpcalc
    apt-get install -y --no-install-recommends \
        libchromaprint-tools && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

#COPY --chown=radarr:radarr userfs /
COPY --chown=radarr:radarr userfs-arm /

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
