#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Homebridge
# Applies temporary but necessary patch to HAP NodeJS
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly EVENTHTTP_FILE='/usr/lib/node_modules/homebridge/node_modules/hap-nodejs/lib/util/eventedhttp.js'

if hass.config.false 'enable_ipv6'; then
    patch "${EVENTHTTP_FILE}" <<PATCH
--- eventedhttp.js
+++ eventedhttp.js
@@ -57,7 +57,7 @@
inherits(EventedHTTPServer, EventEmitter);

EventedHTTPServer.prototype.listen = function(targetPort) {
-  this._tcpServer.listen(targetPort);
+  this._tcpServer.listen(targetPort, '0.0.0.0');

this._tcpServer.on('listening', function() {
    var port = this._tcpServer.address().port;
PATCH

    # shellcheck disable=SC2181
    if [[ "$?" -ne 0 ]];
    then
        hass.die 'Patching HAP NodeJS failed'
    fi

    hass.log.debug 'Applied HAP NodeJS IPv6 disable hotfix'
fi