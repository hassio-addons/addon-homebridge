#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Ensures we've got an unique D-Bus ID
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

dbus-uuidgen --ensure || hass.die 'Failed to generate a unique D-Bus ID'
