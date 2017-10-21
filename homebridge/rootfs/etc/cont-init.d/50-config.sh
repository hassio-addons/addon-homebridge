#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Generates the Homebridge configuration file
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# Configuration paths
readonly HOMEBRIDGE_CONFIG_FILE=/config/homebridge/config.json
readonly HOMEBRIDGE_TEMPLATE_CONFIG_FILE=/root/homebridge-config.json

# ------------------------------------------------------------------------------
# Generates a random pin number for HomeKit (###-##-### format)
#
# Arguments:
#   None
# Returns:
#   The generated random pin number
# ------------------------------------------------------------------------------
generate_homekit_pin() {
  local pin

  pin=$(< /dev/urandom tr -dc 0-9 | head -c3)
  pin+="-"
  pin+=$(< /dev/urandom tr -dc 0-9 | head -c2)
  pin+="-"
  pin+=$(< /dev/urandom tr -dc 0-9 | head -c3)

  echo "$pin"
}

# ------------------------------------------------------------------------------
# Finds the MAC address of the main interface
#
# Arguments:
#   None
# Returns:
#   MAC address of the main interface (upper-cased)
# ------------------------------------------------------------------------------
get_mac_addr() {
  local interface
  local mac

  interface=$(ip route show default | awk '/default/ {print $5}')
  mac=$(cat "/sys/class/net/$interface/address")

  echo "${mac^^}"
}

# Create Homebridge configuration directory when it is missing
if ! hass.directory_exists "$(dirname "${HOMEBRIDGE_CONFIG_FILE}")"; then
    mkdir -p "$(dirname "${HOMEBRIDGE_CONFIG_FILE}")" \
        || hass.die 'Failed to create Homebrige configuration directory'
fi

# Generate Homebridge configuration file, when missing
if ! hass.file_exists "${HOMEBRIDGE_CONFIG_FILE}"; then
    cp "${HOMEBRIDGE_TEMPLATE_CONFIG_FILE}" "${HOMEBRIDGE_CONFIG_FILE}" \
        || hass.die 'Failed creating Homebridge configuration file'

    sed -i "s/%%USERNAME%%/$(get_mac_addr)/g" "${HOMEBRIDGE_CONFIG_FILE}" \
        || hass.die 'Failed setting Homebridge username'

    sed -i "s/%%PIN%%/$(generate_homekit_pin)/g" "${HOMEBRIDGE_CONFIG_FILE}" \
        || hass.die 'Failed setting Homebridge pin'
fi