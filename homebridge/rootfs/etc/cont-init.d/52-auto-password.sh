#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Ensures the correct API key is in the Homebridge configuration
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG_FILE="/config/homebridge/config.json"
declare TMP_FILE

if [[ "$(jq -r '.platforms[] | select(.platform=="HomeAssistant") | .host' ${CONFIG_FILE})" = "http://hassio/homeassistant"
    && "$(jq -r '.platforms[] | select(.platform=="HomeAssistant") | .password' ${CONFIG_FILE})" != "${HASSIO_TOKEN}" ]];
then
    TMP_FILE=$(mktemp)

    hass.log.info 'Password is missing in the Homebridge configuration, fixing...'

    jq "(.platforms[] | select(.platform==\"HomeAssistant\"))=((.platforms[] | select(.platform==\"HomeAssistant\")) + { \"password\": \"${HASSIO_TOKEN}\" })" \
        "${CONFIG_FILE}" > "${TMP_FILE}" \
        || hass.die 'Failed to set Hass.io API token into the Homebridge config'

    mv "${TMP_FILE}" "${CONFIG_FILE}" \
        || hass.die 'Failed updating the Hass.io configuration'
fi
