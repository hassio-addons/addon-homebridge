#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Checks the currently used HA URL and warns if the Hass.io proxy isn't used
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG_FILE=/config/homebridge/config.json
readonly HA_URL=$(jq -r '.platforms[] | select(.platform=="HomeAssistant") | .host' ${CONFIG_FILE})

if [[ "${HA_URL}" != "http://hassio/homeassistant" ]]; then
    hass.log.warning 'You are using an non-recommended Home Assistant URL!'
    hass.log.warning 'Setting the "ha_url" option in your AppDaemon config to'
    hass.log.warning '"http://hassio/homeassistant" is recommended!'
fi
