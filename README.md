# Community Hass.io Add-ons: Homebridge

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE.md)

[![GitLab CI][gitlabci-shield]][gitlabci]
![Project Maintenance][maintenance-shield]
[![GitHub Activity][commits-shield]][commits]

[![Bountysource][bountysource-shield]][bountysource]
[![Discord][discord-shield]][discord]
[![Community Forum][forum-shield]][forum]

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

[![Support my work on Patreon][patreon-shield]][patreon]

This add-on provides the installation, configuration, and integration for
[Homebridge][homebridge].

## Deprecation warning

**This add-on is in a deprecated state!**

At this point it is unsure how long this add-on keeps available or
updated.

This add-on was originally developed to add HomeKit support to
Home Assistant. Meanwhile, Home Assistant gained native support
for HomeKit.

<https://www.home-assistant.io/components/homekit/>

Because of this, is very likely that the plugins this add-on rely, on
will no longer be developed or maintained.

We **STRONGLY** suggest to migrate to the Home Assistant HomeKit component.

## About

Homebridge is a server that emulates the iOS HomeKit API, allowing you to
control your Home Assistant via Apple devices (including Siri).

Since Siri supports devices added through HomeKit, this means that with
Homebridge you can ask Siri to control devices that don't have any support for
HomeKit at all. For instance, you could say:

- _Siri, unlock the back door._
- _Siri, open the garage door._
- _Siri, turn on the coffee maker._
- _Siri, turn on the living room lights._
- _Siri, good morning!_

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. [Add our Hass.io add-ons repository][repository] to your Hass.io instance.
1. Install the "Homebridge" add-on.
1. Start the "Homebridge" add-on.
1. Check the logs of the "Homebridge" add-on to see if everything went well
  moreover, to find the pin code needed to add your Home Assistant instance to
  your iOS device

Please read the rest of this document further instructions.

**NOTE**: Do not add this repository to Hass.io, please use:
`https://github.com/hassio-addons/repository`.

## Docker status

[![Docker Architecture][armhf-arch-shield]][armhf-dockerhub]
[![Docker Version][armhf-version-shield]][armhf-microbadger]
[![Docker Layers][armhf-layers-shield]][armhf-microbadger]
[![Docker Pulls][armhf-pulls-shield]][armhf-dockerhub]
[![Anchore Image Overview][armhf-anchore-shield]][armhf-anchore]

[![Docker Architecture][aarch64-arch-shield]][aarch64-dockerhub]
[![Docker Version][aarch64-version-shield]][aarch64-microbadger]
[![Docker Layers][aarch64-layers-shield]][aarch64-microbadger]
[![Docker Pulls][aarch64-pulls-shield]][aarch64-dockerhub]
[![Anchore Image Overview][aarch64-anchore-shield]][aarch64-anchore]

[![Docker Architecture][amd64-arch-shield]][amd64-dockerhub]
[![Docker Version][amd64-version-shield]][amd64-microbadger]
[![Docker Layers][amd64-layers-shield]][amd64-microbadger]
[![Docker Pulls][amd64-pulls-shield]][amd64-dockerhub]
[![Anchore Image Overview][amd64-anchore-shield]][amd64-anchore]

[![Docker Architecture][i386-arch-shield]][i386-dockerhub]
[![Docker Version][i386-version-shield]][i386-microbadger]
[![Docker Layers][i386-layers-shield]][i386-microbadger]
[![Docker Pulls][i386-pulls-shield]][i386-dockerhub]
[![Anchore Image Overview][i386-anchore-shield]][i386-anchore]

## Configuration

On the first run, this add-on creates the necessary configuration files
for you. Stored in `/config/homebridge/`. You can modify the configuration
to your liking. For documentation on configuring Homebridge, please refer
to the [Homebridge GitHub][homebridge] repository. For documentation on
configuring the Home Assistant for Homebridge plugin, please refer to the
[Home Assistant for Homebridge GitHub][homebridge-homeassistant] repository.

The add-on has a configuration possibilities as well.

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```json
{
  "log_level": "info",
  "avahi_interfaces": "",
  "avahi_hostname": "",
  "avahi_domainname": "local",
  "enable_ipv6": true,
  "packages": [],
  "init_commands": [],
  "plugins": []
}
```

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

Using `trace` or `debug` log levels puts the Homebridge server into debug mode.

### Option: `avahi_interfaces`

Set a comma separated list of allowed network interfaces that should be used by
the Avahi service. Other interfaces will be ignored. If left empty, the add-on
will try to auto-detect the interfaces, which should be fine in most cases.

**Note**: _There is a special internal interface for Hass.io called `hassio`.
This interface is always added to the list automatically_

### Option: `avahi_hostname`

Set the hostname to Avahi server. The add-on tries to register on your network
using this hostname. If left empty the hostname will be automatically detected
via the Hass.io API, which sould be fine in most cases.

### Option: `avahi_domainname`

Set the default domain name for Avahi. The add-on tries to register its hostname
and services on your network. In most cases, the default, `local`, should be
fine.

### Option: `enable_ipv6`

In some situations, IPv6 might cause more problems then it solves.
Setting this option to `false`, partially disables IPv6 support causing
Ahahi and Homebridge to only listen for connections on IPv4

### Option: `insecure`

Allow unauthenticated requests to Homebridge (for easier hacking). Some
plugins require this as well. Be aware of the possible security implication
this has.

### Option: `packages`

Allows you to specify additional [Alpine packages][alpine-packages] to be
installed to your Homebridge setup (e.g., `python`, `g++`. `make`, `ffmpeg`).

**Note**: _Adding many packages will result in a longer start-up time
for the add-on._

### Option: `init_commands`

Customize your Homebridge setup even more with the `init_commands` option.
Add one or more shell commands to the list, and they will be executed every
single time this add-on starts.

### Option: `plugins`

This Homebridge add-on has support for installing additional Homebridge plugins.
Plugins are NodeJS modules published through NPM and tagged with the keyword
`homebridge-plugin`. They must have a name with the prefix `homebridge-`,
like `homebridge-mysmartlock`.

The `homebridge-homeassistant` plugin is already installed for you.

You can install a plugin by adding it to the add-on configuration. The add-on
ensures the plugin is installed on start.

Example add-on configuration (partial):

```json
{
  "plugins": [
    "homebridge-dummy",
    "homebridge-mysmartlock"
  ]
}
```

You can explore all available plugins at the NPM website by
[searching for the keyword homebridge-plugin][homebridge-plugins].

**Note**: _Some plugins require build tools or other packages. You might need to
install these packages using the `packages` option first._

## Adding Homebridge to iOS

Using the Home app (or most other HomeKit apps), you should be able to add the
single accessory "Home Assistant", assuming that you are still running the
Homebridge add-on and you are on the same (Wifi) network. Adding this accessory
automatically adds all accessories and platforms defined in your
Home Assistant instance.

When you attempt to add the "Home Assistant" accessory, it will ask for a
"PIN code". This pin code is randomly generated when this add-on is run for
the first time. You can find the generated PIN code in the add-on logs and in
your `/config/homebridge/config.json` file (where you, of course,
can change it as well).

## Known issues and limitations

- Once your device has been added to HomeKit, you should be able to tell Siri to
  control your devices. However, realize that Siri is a cloud service and iOS
  may need some time to synchronize your device information with iCloud.
- Siri will almost always prefer its default phrase handling over HomeKit
  devices. For instance, if you name your Sonos device "Radio" and try saying
  "Siri, turn on the Radio" then Siri will probably start playing an iTunes Radio
  station on your phone. Even if you name it "Sonos" and say
  "Siri, turn on the Sonos", Siri will probably just launch the Sonos app instead.
  This is why, for instance, the suggested `name` for the Sonos accessory
  is "Speakers".
- One installation of Homebridge can only expose 100 accessories due to a
  HomeKit limit.
- Once an accessory has been added to the Home app, changing its name via
  Homebridge will not be automatically reflected in iOS. You must change it via
  the Home app as well.
- If you have set up SSL using a self-signed certificate, you will need to
  set `verify_ssl` to false in your `/config/homebridge/config.json` file to
  allow bypassing the NodeJS certificate checks.
- Errors on startup. The following errors are experienced when starting
  Homebridge and can be safely ignored.

```txt
*** WARNING *** The program 'nodejs' uses the Apple Bonjour compatibility layer
of Avahi
*** WARNING *** Please fix your application to use the native API of Avahi!
*** WARNING *** For more information see
http://0pointerde/avahi-compat?s=libdns_sd&e=nodejs
*** WARNING *** The program 'nodejs' called 'DNSServiceRegister()' which is not
supported (or only supported partially) in the Apple Bonjour compatibility layer
of Avahi
*** WARNING *** Please fix your application to use the native API of Avahi!
*** WARNING *** For more information see
http://0pointerde/avahi-compat?s=libdns_sd&e=nodejs&f=DNSServiceRegister
```

## FAQ

### Homebridge cannot connect or login to Home Assistant

Please be sure to set the `host` and `password` parameters in the
`/config/homebridge/config.json` file.

We recommend using `http://hassio/homeassistant` as the `host` with an
empty `password`, which allows Homebridge to talk to Home Assistant directly.

### My iOS App Cannot Find Homebridge/Home Assistant

Two reasons why Homebridge may not be discoverable:

1. Homebridge server thinks it has been paired with, but iOS thinks otherwise.
  Fix: deleted `persist/` directory which is in your `config/homebridge`
  directory and restart the add-on.

1. iOS device has gotten your Homebridge `username` (looks like a MAC address)
  "stuck" somehow, where it is in the database but inactive. Fix: change your
  `username` in the "bridge" section of `/config/homebridge/config.json` to be
  some new value and restart the add-on.

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality. The format of the log is based on
[Keep a Changelog][keepchangelog].

Releases are based on [Semantic Versioning][semver], and use the format
of ``MAJOR.MINOR.PATCH``. In a nutshell, the version will be incremented
based on the following:

- ``MAJOR``: Incompatible or major changes.
- ``MINOR``: Backwards-compatible new features and enhancements.
- ``PATCH``: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- The [Community Hass.io Add-ons Discord chat server][discord] for add-on
  support and feature requests.
- The [Home Assistant Discord chat server][discord-ha] for general Home
  Assistant discussions and questions.
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We have set up a separate document containing our
[contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## Credits

A big shout out to the following people, without them this add-on was not
possible:

- The team & community of [Home Assistant][home-assistant] for developing such
  an excellent home automation toolkit
- [Nick Farina][nfarina] for developing [Homebrige][homebridge]

This add-on has been inspired by the following repositories:

- [docker-homebridge][oznu-docker-homebridge] by [Oznu][oznu]
- [homebridge-docker][ckuburlis-homebridge-docker]by [ckuburlis]
- [hassio-addons][olivierguerriat-hassio-addons]
  by [Olivier Guerriat][olivierguerriat]

Thank you all!

## We have got some Hass.io add-ons for you

Want some more functionality to your Hass.io Home Assistant instance?

We have created multiple add-ons for Hass.io. For a full list, check out
our [GitHub Repository][repository].

## License

MIT License

Copyright (c) 2017 Franck Nijhof

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-anchore-shield]: https://anchore.io/service/badges/image/e1fe7eff6060158fd4f39bb33fd9cf79cff0d6f15cbbbdb748288c14af47098c
[aarch64-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fhomebridge-aarch64%3Alatest
[aarch64-arch-shield]: https://img.shields.io/badge/architecture-aarch64-blue.svg
[aarch64-dockerhub]: https://hub.docker.com/r/hassioaddons/homebridge-aarch64
[aarch64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/homebridge-aarch64.svg
[aarch64-microbadger]: https://microbadger.com/images/hassioaddons/homebridge-aarch64
[aarch64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/homebridge-aarch64.svg
[aarch64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/homebridge-aarch64.svg
[alpine-packages]: https://pkgs.alpinelinux.org/
[amd64-anchore-shield]: https://anchore.io/service/badges/image/2b9a78e147678b80fc0e8c63537c669b803f605555d055fba8fe5bd01a5ea60c
[amd64-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fhomebridge-amd64%3Alatest
[amd64-arch-shield]: https://img.shields.io/badge/architecture-amd64-blue.svg
[amd64-dockerhub]: https://hub.docker.com/r/hassioaddons/homebridge-amd64
[amd64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/homebridge-amd64.svg
[amd64-microbadger]: https://microbadger.com/images/hassioaddons/homebridge-amd64
[amd64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/homebridge-amd64.svg
[amd64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/homebridge-amd64.svg
[armhf-anchore-shield]: https://anchore.io/service/badges/image/7a31261290489f95ff24e504a87b93d5d852f4f81b403a3de2f55db908e1e782
[armhf-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fhomebridge-armhf%3Alatest
[armhf-arch-shield]: https://img.shields.io/badge/architecture-armhf-blue.svg
[armhf-dockerhub]: https://hub.docker.com/r/hassioaddons/homebridge-armhf
[armhf-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/homebridge-armhf.svg
[armhf-microbadger]: https://microbadger.com/images/hassioaddons/homebridge-armhf
[armhf-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/homebridge-armhf.svg
[armhf-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/homebridge-armhf.svg
[bountysource-shield]: https://img.shields.io/bountysource/team/hassio-addons/activity.svg
[bountysource]: https://www.bountysource.com/teams/hassio-addons/issues
[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg
[buymeacoffee]: https://www.buymeacoffee.com/frenck
[ckuburlis-homebridge-docker]: https://github.com/ckuburlis/homebridge-docker
[ckuburlis]: https://github.com/ckuburlis
[commits-shield]: https://img.shields.io/github/commit-activity/y/hassio-addons/addon-homebridge.svg
[commits]: https://github.com/hassio-addons/addon-homebridge/commits/master
[contributors]: https://github.com/hassio-addons/addon-homebridge/graphs/contributors
[discord-ha]: https://discord.gg/c5DvZ4e
[discord-shield]: https://img.shields.io/discord/478094546522079232.svg
[discord]: https://discord.me/hassioaddons
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io/t/community-hass-io-add-on-homebridge/33803?u=frenck
[frenck]: https://github.com/frenck
[gitlabci-shield]: https://gitlab.com/hassio-addons/addon-homebridge/badges/master/pipeline.svg
[gitlabci]: https://gitlab.com/hassio-addons/addon-homebridge/pipelines
[home-assistant]: https://home-assistant.io
[homebridge-homeassistant]: https://github.com/home-assistant/homebridge-homeassistant
[homebridge-plugins]: https://www.npmjs.com/search?q=homebridge-plugin
[homebridge]: https://github.com/nfarina/homebridge
[i386-anchore-shield]: https://anchore.io/service/badges/image/4f3282de1b844e95b246ad7271392feee3bff81abbdbdedc8357f306b705ae75
[i386-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fhomebridge-i386%3Alatest
[i386-arch-shield]: https://img.shields.io/badge/architecture-i386-blue.svg
[i386-dockerhub]: https://hub.docker.com/r/hassioaddons/homebridge-i386
[i386-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/homebridge-i386.svg
[i386-microbadger]: https://microbadger.com/images/hassioaddons/homebridge-i386
[i386-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/homebridge-i386.svg
[i386-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/homebridge-i386.svg
[issue]: https://github.com/hassio-addons/addon-homebridge/issues
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[license-shield]: https://img.shields.io/github/license/hassio-addons/addon-homebridge.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2018.svg
[nfarina]: https://github.com/nfarina
[olivierguerriat-hassio-addons]: https://github.com/olivierguerriat/hassio-addons
[olivierguerriat]: https://github.com/olivierguerriat
[oznu-docker-homebridge]: https://github.com/oznu/docker-homebridge
[oznu]: https://github.com/oznu
[patreon-shield]: https://www.frenck.nl/images/patreon.png
[patreon]: https://www.patreon.com/frenck
[project-stage-shield]: https://img.shields.io/badge/project%20stage-%20!%20DEPRECATED%20%20%20!-ff0000.svg
[reddit]: https://reddit.com/r/homeassistant
[releases-shield]: https://img.shields.io/github/release/hassio-addons/addon-homebridge.svg
[releases]: https://github.com/hassio-addons/addon-homebridge/releases
[repository]: https://github.com/hassio-addons/repository
[semver]: http://semver.org/spec/v2.0.0.htm
