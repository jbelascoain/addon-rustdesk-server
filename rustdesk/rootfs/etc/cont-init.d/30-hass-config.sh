#!/usr/bin/with-contenv bashio

S6_ENV_DIR="/run/s6/container_environment/"
mkdir -p "${S6_ENV_DIR}"

bashio::log.info "----------------------------------------------------"
bashio::log.info "  Setting up global environment variables for s6..."
bashio::log.info "----------------------------------------------------"

if bashio::config.true 'encrypted_only'; then
    echo -n "1" > "${S6_ENV_DIR}/ENCRYPTED_ONLY"
else
    echo -n "0" > "${S6_ENV_DIR}/ENCRYPTED_ONLY"
fi

echo -n "$(bashio::config 'relay_server')" > "${S6_ENV_DIR}/RELAY"

bashio::log.info "Global environment variables are ready for all services."