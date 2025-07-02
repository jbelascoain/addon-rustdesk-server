# Home Assistant Add-on: RustDesk Server
[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE.md)

![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports i386 Architecture][i386-shield]

![Project Maintenance][maintenance-shield]
[![GitHub Activity][commits-shield]][commits]

Self-hosted RustDesk Server as a Home Assistant addon.

## About

[RustDesk](https://rustdesk.com/) is an open-source remote desktop software, an alternative to TeamViewer and AnyDesk. It allows you to control your devices from anywhere. By self-hosting your own server, all control and security of your remote connections remain on your own network, without relying on third-party servers.

This addon installs and configures the two main components of the RustDesk server:
* **hbbs**: The ID and Signaling Server (the "brain" that manages connections).
* **hbbr**: The Relay Server (relays traffic if a direct P2P connection is not possible).

This addon is based on version **1.1.14** of RustDesk Server.

---

## Installation

This addon can be installed through the Home Assistant Add-on Store.

1.  Navigate to **Settings > Add-ons > Add-on Store**.
2.  Click the three-dots menu in the top-right corner and select **Repositories**.
3.  Add the URL of this repository and click **Add**.
4.  Find the "RustDesk Server" addon in the store and click **Install**.
5.  Once installed, configure it as described below before starting.

---

## Configuration

The addon's options can be set in the "Configuration" tab on the addon's page.

### Option: `encrypted_only`

-   **Type**: `bool` (toggle)
-   **Default value**: `true`

Controls whether the `hbbs` server will enforce end-to-end encryption for all client connections. It is strongly recommended to keep this option enabled for maximum security.

### Option: `relay_server`

-   **Type**: `str` (text)
-   **Default value**: `127.0.0.1`

This option tells your ID server (`hbbs`) the public address of your relay server (`hbbr`).

**Important:** For most setups where both services run within this addon, this option **should be left blank (`""`)**. `hbbs` will connect to the local `hbbr` automatically. The default value of `127.0.0.1` can cause issues and should be cleared.

You should only fill this in if you are using a relay server running on a separate machine.

---

## Network and Port Configuration

For RustDesk clients to connect to your server from outside your local network, **you must configure port forwarding** on your router.

You need to forward the following ports to the IP address of your Home Assistant machine:

| Port  | Protocol  | Service Description                                    |
| :---- | :-------- | :----------------------------------------------------- |
| 21115 | TCP       | `hbbs`: Used for the NAT type test.                    |
| 21116 | TCP       | RustDesk Main Server (Signaling, WebSocket)            |
| 21116 | UDP       | RustDesk Main Server (Heartbeat, Hole Punching)        |
| 21117 | TCP       | `hbbr`: Used for the Relay services.                   |
| 21118 | TCP       | `hbbs`: Used to support web clients.                   |
| 21119 | TCP       | `hbbr`: Used to support web clients.                   |

---

## Support

If you find an issue or have a suggestion, please open an Issue on this GitHub repository.

## License

MIT License

Copyright (c) 2025 Iñaki

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

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg