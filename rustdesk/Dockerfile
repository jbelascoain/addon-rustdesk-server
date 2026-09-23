ARG BUILD_FROM=ghcr.io/hassio-addons/base:21.0.5
FROM ${BUILD_FROM}

ARG RUSTDESK_SERVER_VERSION="1.1.16"
ARG BUILD_ARCH="amd64"
ARG BUILD_VERSION="dev"

LABEL \
  io.hass.name="RustDesk Server" \
  io.hass.description="RustDesk Signal and Relay Server" \
  io.hass.type="app" \
  io.hass.version="${BUILD_VERSION}"

RUN \
    apk update && \
    apk add --no-cache \
        unzip \
    \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then RUSTDESK_SERVER_ARCH="arm64v8"; \
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
