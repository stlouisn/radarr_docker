FROM stlouisn/ubuntu:latest AS dl

ARG TARGETARCH

RUN \

    # Non-interactive frontend
    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache
    apt-get update && \

    # Install jq
    apt-get install -y --no-install-recommends \
        jq && \

    # Determine Latest Stable Radar Version
    export APP_VERSION="$(curl -sSL --retry 5 --retry-delay 2 "https://radarr.servarr.com/v1/update/master/changes" | jq -r '.[0].version')" && \

    # Download Radarr
    if [ "arm" = "$TARGETARCH" ] ; then curl -o /tmp/radarr.tar.gz -sSL "https://github.com/Radarr/Radarr/releases/download/v$APP_VERSION/Radarr.master.$APP_VERSION.linux-core-arm.tar.gz" ; fi && \
    if [ "arm64" = "$TARGETARCH" ] ; then curl -o /tmp/radarr.tar.gz -sSL "https://github.com/Radarr/Radarr/releases/download/v$APP_VERSION/Radarr.master.$APP_VERSION.linux-core-arm64.tar.gz" ; fi && \

    # Extract Radarr
    mkdir -p /userfs && \
    tar -xf /tmp/radarr.tar.gz -C /userfs/ && \

    # Disable Radarr-Update
    rm -r /userfs/Radarr/Radarr.Update/

FROM stlouisn/ubuntu:latest

COPY rootfs /

RUN \

    # Non-interactive frontend
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

    # Install unicode support
    apt-get install -y --no-install-recommends \
        libicu70 && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

COPY --chown=radarr:radarr --from=dl /userfs /

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
