# HA Bridge Hass.io Add-On
---------

[Hass.io](https://home-assistant.io/hassio/) add-on for [HA Bridge](https://github.com/bwssytems/ha-bridge).

## Installation

1. Add my [Hass.io](https://home-assistant.io/hassio/) add-on [repository](https://github.com/notoriousbdg/hassio-addons) - https://github.com/notoriousbdg/hassio-addons
2. Install the `HA Bridge` add-on
3. Edit the configuration options
	1. Change serverip to the IP of the Hass.io machine (e.g. `192.168.0.10`)
	2. Leave version set to `latest` to always use the latest version, or manually specify a version (e.g. `4.5.6`).

	```json
	{
  	"serverip": "192.168.0.10",
  	"version": "latest"
	}
	```

4. Start the `HA Bridge` add-on
5. (Optional) Configure [panel_iframe](https://home-assistant.io/components/panel_iframe/) component to embed HA Bridge UI into Home Assistant UI using this example:

	```yaml
	iframe_panel:
  	habridge:
	    title: 'HA Bridge'
	    url: 'http://hassio.local:80'
	    icon: mdi:lightbulb-on-outline
	```

## Support

Please use [this thread](https://community.home-assistant.io/t/repository-notoriousbdg-add-ons-node-red-and-ha-bridge/23247) for feedback.

## FAQ

### Q: What ports does HA Bridge use?
A: tcp/80 (HTTP), udp/1900 (UPNP), and udp/50000 (UPNP)


## Changelog

### 4.5.6 (2017-07-31)
#### Initial Release

### 4.5.6p1 (2017-08-03)
#### Added
- Map /share folder as read/write
- Map /ssl folder as read only
#### Changed
- Migrated configuration to /share/habridge
- Fixed issue preventing Alexa from discovering devices
