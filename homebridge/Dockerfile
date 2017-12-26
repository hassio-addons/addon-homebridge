ARG BUILD_FROM=hassioaddons/base-amd64:1.3.0
FROM ${BUILD_FROM}

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        avahi-dev \
        g++ \
        libffi-dev \
        make \
        openssl-dev \
        python \
    \
    && apk add --no-cache \
        avahi \
        avahi-compat-libdns_sd \
        dbus \
        git \
        nodejs \
        nodejs-npm \
    \
    && npm set unsafe-perm true \
    \
    && npm -g install \
        node-gyp \
        homebridge@0.4.33 \
        homebridge-homeassistant@3.0.2 \
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
