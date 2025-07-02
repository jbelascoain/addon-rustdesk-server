ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG RUSTDESK_SERVER_VERSION
ARG BUILD_ARCH

RUN \
    apk update && \
    apk add --no-cache \
        unzip \
    \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then RUSTDESK_SERVER_ARCH="arm64v8"; \
        elif [ "${BUILD_ARCH}" = "armhf" ]; then RUSTDESK_SERVER_ARCH="armv7"; \
        else RUSTDESK_SERVER_ARCH="${BUILD_ARCH}";fi \
    \
    && curl -J -L -o /tmp/rustdesk_server.zip \
        "https://github.com/rustdesk/rustdesk-server/releases/download/${RUSTDESK_SERVER_VERSION}/rustdesk-server-linux-${RUSTDESK_SERVER_ARCH}.zip" \
    && unzip -j -o /tmp/rustdesk_server.zip '*/hbbs' '*/hbbr' '*/rustdesk-utils' -d /usr/bin/ \
    \
    && curl -J -L -o /tmp/source.zip \
        "https://github.com/rustdesk/rustdesk-server/archive/refs/tags/${RUSTDESK_SERVER_VERSION}.zip" \
    && unzip -o /tmp/source.zip "rustdesk-server-${RUSTDESK_SERVER_VERSION}/docker/rootfs/*" -d /tmp \
    && cp -a /tmp/rustdesk-server-${RUSTDESK_SERVER_VERSION}/docker/rootfs/* / \
    \
    && find "/etc/s6-overlay/s6-rc.d/" -type f -exec sed -i 's|/data|/config|g' {} + \
    \
    && rm -rf /tmp/* \
    \
    && chmod a+x /usr/bin/hbbs /usr/bin/hbbr /usr/bin/rustdesk-utils 

COPY rootfs /

EXPOSE 21115 21116 21116/udp 21117 21118 21119

HEALTHCHECK --interval=10s --timeout=5s CMD /usr/bin/healthcheck.sh

WORKDIR /config
VOLUME /config

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Iñaki <jbelascoain@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}