#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Configures the Avahi daemon
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly AVAHI_CONFIG='/etc/avahi/avahi-daemon.conf'
declare interfaces
declare hostname

# Determine interface to use for Avahi
if hass.config.has_value 'avahi_interfaces'; then
    interfaces=$(hass.config.get 'avahi_interfaces')
else
    interfaces=$(ip route show default | awk '/default/ {print $5}')
    hass.log.debug "Detected Avahi interfaces: ${interfaces}"
fi
sed -i "s/#allow-interfaces=.*/allow-interfaces=hassio,${interfaces}/" \
    "${AVAHI_CONFIG}"

# Find the hostname
if hass.config.has_value 'avahi_hostname'; then
    hostname=$(hass.config.get 'avahi_hostname')
else
    hostname=$(hass.api.host.info.hostname)
    hass.log.debug "Detected Avahi hostname: ${hostname}"
fi
sed -i "s/host-name=.*/host-name=${hostname}/" "${AVAHI_CONFIG}"

# Set the domainname
if hass.config.has_value 'avahi_domainname'; then
    sed -i "s/domain-name=.*/domain-name=$(hass.config.get 'avahi_domainname')/" \
        "${AVAHI_CONFIG}"
fi

# Disable IPV6?
if hass.config.false 'enable_ipv6'; then
    sed -i "s/use-ipv6=.*/use-ipv6=no/" "${AVAHI_CONFIG}"
    sed -i "s/publish-aaaa-on-ipv4=.*/publish-aaaa-on-ipv4=no/" "${AVAHI_CONFIG}"
    sed -i "s/publish-a-on-ipv6=.*/publish-a-on-ipv6=no/" "${AVAHI_CONFIG}"
    hass.log.debug 'Disabled IPV6 in the Avahi daemon'
fi

# Remove some problematic Avahi service files
rm -f /etc/avahi/services/*
