#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Runs Homebridge
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly HOMEBRIDGE_CONFIG_FILE=/config/homebridge/config.json

# Wait at least 5 seconds before staring Homebridge
# Avahi might need some time.
sleep 5

if hass.debug; then
  homebridge -D -U "$(dirname "$HOMEBRIDGE_CONFIG_FILE")"
else
  homebridge -U "$(dirname "$HOMEBRIDGE_CONFIG_FILE")"
fi
