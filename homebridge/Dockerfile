ARG BUILD_FROM=hassioaddons/base:2.1.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        avahi-dev=0.7-r1 \
        g++=6.4.0-r8 \
        libffi-dev=3.2.1-r4 \
        make=4.2.1-r2 \
        openssl-dev=1.0.2o-r2 \
        python2=2.7.15-r1 \
    \
    && apk add --no-cache \
        avahi=0.7-r1 \
        avahi-compat-libdns_sd=0.7-r1 \
        dbus=1.10.24-r1 \
        git=2.18.0-r0 \
        nodejs=8.11.4-r0 \
        nodejs-npm=8.11.4-r0 \
    \
    && npm set unsafe-perm true \
    \
    && npm -g install \
        node-gyp@3.8.0 \
        homebridge@0.4.44 \
        homebridge-homeassistant@3.1.0 \
    \
    && apk del --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Homebridge" \
    io.hass.description="HomeKit support for your Home Assistant instance using Homebridge" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="HomeKit support for your Home Assistant instance using Homebridge" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Homebridge" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-homebridge/33803?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-homebridge/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-homebridge" \
    org.label-schema.vendor="Community Hass.io Add-ons"
