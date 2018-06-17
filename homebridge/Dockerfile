ARG BUILD_FROM=hassioaddons/base-amd64:1.4.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        avahi-dev=0.6.32-r4 \
        g++=6.4.0-r5 \
        libffi-dev=3.2.1-r4 \
        make=4.2.1-r0 \
        openssl-dev=1.0.2o-r0 \
        python2=2.7.14-r2 \
    \
    && apk add --no-cache \
        avahi=0.6.32-r4 \
        avahi-compat-libdns_sd=0.6.32-r4 \
        dbus=1.10.24-r0 \
        git=2.15.2-r0 \
        nodejs=8.9.3-r1 \
        nodejs-npm=8.9.3-r1 \
    \
    && npm set unsafe-perm true \
    \
    && npm -g install \
        node-gyp@3.7.0 \
        homebridge@0.4.42 \
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
