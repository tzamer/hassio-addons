# HA Bridge Hass.io Add-On
---------

[Hass.io](https://home-assistant.io/hassio/) add-on for [HA Bridge](https://github.com/bwssytems/ha-bridge).

## Installation

1. Add my [Hass.io](https://home-assistant.io/hassio/) add-on [repository](https://github.com/notoriousbdg/hassio-addons)
2. Install the "HA Bridge" add-on
3. Start the "HA Bridge" add-on
4. (Optional) Configure [panel_iframe](https://home-assistant.io/components/panel_iframe/) component to embed HA Bridge UI into Home Assistant UI using this example:

```yaml
iframe_panel:
  habridge:
    title: 'HA Bridge'
    url: 'http://hassio.local:8080'
    icon: mdi:lightbulb-on-outline
```

## Support

Something doesn't work as expected? Please open an [issue](https://github.com/notoriousbdg/hassio-addons/issues).
