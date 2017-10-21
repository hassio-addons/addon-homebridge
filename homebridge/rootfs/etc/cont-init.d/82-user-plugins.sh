#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Install user configured/requested packages
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.has_value 'plugins'; then
    for plugin in $(hass.config.get 'plugins'); do
        npm install --unsafe-perm -g "${plugin}" \
            || hass.die "Failed installing plugin ${plugin}"
    done
fi
