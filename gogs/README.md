# Gogs Hass.io Add-On
---------

[Hass.io](https://home-assistant.io/hassio/) add-on for [Gogs](https://gogs.io/).  Gogs is a painless self-hosted Git service.

## Installation

1. Add my [Hass.io](https://home-assistant.io/hassio/) add-on [repository](https://github.com/notoriousbdg/hassio-addons) - https://github.com/notoriousbdg/hassio-addons
2. Install the `Gogs` add-on
3. (Optional) To enable SSL support, set SSL to true.

    ```json
    {
      "ssl": true,
      "certfile": "fullchain.pem",
      "keyfile": "privkey.pem"
    }
    ```

4. Start the `Gogs` add-on
5. Navigate to [http://hassio.local:10080](http://hassio.local:10080)
6. Complete the install wizard (All fields, other than the database oes, must be configured as shown for Gogs to work correctly)


| Field                | Value                       |
|----------------------|-----------------------------|
| Database Type        | SQLite3                     |
| Path                 | /data/gogs.db               |
| Application Name     | Gogs                        |
| Repository Root Path | /data/git/gogs-repositories |
| Run User             | git                         |
| Domain               | hassio.local                |
| SSH Port             | 10022                       |
| HTTP Port            | 3000                        |
| Application URL      | http://hassio.local:10080/  |
| Log Path             | /app/gogs/log               |

7. (Optional) If you enabled SSL support, restart Gogs addon to finish the SSL configuration.
8. Refer to [Gogs Documentation](https://gogs.io/docs) for additional configuration and usage information

## Support

Please use [this thread](https://community.home-assistant.io/t/repository-notoriousbdg-add-ons-node-red-and-ha-bridge/23247) for feedback.

## FAQ

### Q: What ports does Gogs use?
A: tcp/10080 (HTTP) is forwarded to tcp/3000 and tcp/10022 (SSH) is forwarded to tcp/22.


## Changelog

### 0.11.19 (2017-08-10)
#### Initial Release

### 0.11.19p1 (2017-08-11)
#### Added
- Option to enable SSL
- Support for amd64 platforms

