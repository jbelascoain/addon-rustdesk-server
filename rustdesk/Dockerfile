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
    && rm -rf /tmp/* \
    \
    && chmod a+x /usr/bin/hbbs /usr/bin/hbbr /usr/bin/rustdesk-utils 

COPY rootfs /

EXPOSE 21115 21116 21116/udp 21117 21118 21119

HEALTHCHECK --interval=10s --timeout=5s CMD /usr/bin/healthcheck.sh

WORKDIR /config
VOLUME /config
