FROM stlouisn/ubuntu:latest AS dl

ARG TARGETARCH

ARG APP_VERSION

ARG DEBIAN_FRONTEND=noninteractive

RUN \

    # Update apt-cache
    apt-get update && \

    # Install jq
    apt-get install -y --no-install-recommends \
        curl && \

    # Download Radarr
    if [ "arm" = "$TARGETARCH" ] ; then curl -o /tmp/radarr.tar.gz -sSL "https://github.com/Radarr/Radarr/releases/download/v$APP_VERSION/Radarr.master.$APP_VERSION.linux-core-arm.tar.gz" ; fi && \
    if [ "arm64" = "$TARGETARCH" ] ; then curl -o /tmp/radarr.tar.gz -sSL "https://github.com/Radarr/Radarr/releases/download/v$APP_VERSION/Radarr.master.$APP_VERSION.linux-core-arm64.tar.gz" ; fi && \
    if [ "amd64" = "$TARGETARCH" ] ; then curl -o /tmp/radarr.tar.gz -sSL "https://github.com/Radarr/Radarr/releases/download/v$APP_VERSION/Radarr.master.$APP_VERSION.linux-core-x64.tar.gz" ; fi && \

    # Extract Radarr
    mkdir -p /userfs && \
    tar -xf /tmp/radarr.tar.gz -C /userfs/ && \

    # Disable Radarr-Update
    rm -r /userfs/Radarr/Radarr.Update/

FROM stlouisn/ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

COPY rootfs /

RUN \

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

    # Determine latest LIBICU version
    export LIBICU=$(apt search libicu | grep "libicu" | grep -v "java" | grep -v "dev" | awk -F '/' {'print $1'}) && \ 

    # Install unicode support
    apt-get install -y --no-install-recommends \
        $LIBICU && \

    # Install xml command line toolkit
    apt-get install -y --no-install-recommends \
        xmlstarlet && \

    # Clean temporary environment variables
    unset LIBICU && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /usr/local/man \
        /usr/local/share/man \
        /usr/share/doc \
        /usr/share/doc-base \
        /usr/share/man \
        /var/cache \
        /var/lib/apt \
        /var/log/*

COPY --chown=radarr:radarr --from=dl /userfs /

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
