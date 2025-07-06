# RustDesk Server Add-on Documentation

This addon allows you to run your own self-hosted RustDesk remote desktop server, giving you full control over your data and connections. This guide will help you configure it correctly.

## How It Works

This addon installs the two components required for a complete server:
* **`hbbs` (ID/Signaling Server):** Acts as a switchboard, allowing your clients to find each other.
* **`hbbr` (Relay Server):** Relays your session traffic if a direct P2P connection is not possible.

## Addon Configuration

Navigate to the **Configuration** tab on the addon's page to adjust the settings.

### Option: `Relay Server`
* **Description:** The public address of your relay server.
* **Usage:** For a standard installation where everything runs within this addon, **you should leave this field blank**. The system will configure itself automatically. Only fill this in if you are running a separate relay server (`hbbr`) on a different machine.

### Option: `Alway Use Relay`
* **Description:** Forces all remote sessions to go through the relay server.
* **Usage:** When enabled, this disables direct P2P connections. This is useful for ensuring connectivity on restrictive corporate networks but will increase your server's bandwidth usage and add latency to the connection. The default is `false`.

### Options: `Public Key` & `Private Key`
* **Description:** These optional fields allow you to manually provide your server's public and private keys.
* **Usage:** This is one of the methods to restore or change your server keys. See the "Managing Your Server Keys" section for more details. **Warning:** Pasting your private key into configuration is less secure than using the generated files.

### Option: `Single Connection Bandwidth Limit `
* **Description:** Limits the maximum bandwidth for a single relay connection, in Mbps.
* **Usage:** Use this to prevent a single remote session from consuming too much bandwidth. Leave blank for default.

### Option: `Total Bandwidth Limit`
* **Description:** Limits the total combined bandwidth that the relay server can use for all active connections, in Mbps.
* **Usage:** This helps control the overall data usage and cost of your server. Leave blank for default.

### Option: `Log Level`
* **Description:** Controls the verbosity of the addon's logs.
* **Usage:** Select the desired level of detail for troubleshooting. "Info" is recommended for normal use. "Debug" or "Trace" provide extensive information for diagnosing problems.

## Network Configuration (Very Important!)

For your RustDesk clients to connect to your server from outside your home network (via the Internet), you need to set up **port forwarding** on your router.

You must forward the following ports to the IP address of your Home Assistant machine:

| Port  | Protocol  | Purpose                                  |
| :---- | :-------- | :--------------------------------------- |
| 21115 | TCP       | NAT Type Test (Helps with connections)     |
| 21116 | TCP/UDP   | Main Server (ID, Signaling, Heartbeat) |
| 21117 | TCP       | Relay Server (Session Traffic)         |

## Client Setup

Once the addon is installed, started, and your ports are forwarded, you must configure your RustDesk client application to use it.

1.  **Get Your Public Key:** You need your server's public key to ensure a secure connection. You can get it in two ways:
    * **From the Addon Log:** The first time the addon starts and generates keys, it will print the public key to the log. Go to the addon's "Log" tab and look for a line that starts with: `INFO [src/rendezvous_server.rs] Key:`. The string that follows is your public key.
    * **From the File System:** Using the "Samba share" or "File editor" addon, navigate to the `/addon_configs` directory in your Home Assistant installation. Find the folder for this addon (e.g., `1fe8b763_rustdesk_server`) and open the `id_ed25519.pub` file. The text inside is your public key.

2.  **Configure the Client:**
    * Open the RustDesk application on your computer.
    * Click the menu button (`...`) next to your ID.
    * Select **"ID/Relay Server"**.
    * Fill in the fields:
        * **ID Server:** Enter the public IP address or domain name of your home (e.g., `my-domain.duckdns.org`).
        * **Relay Server:** Enter the same address as above.
        * **Key:** Paste the public key you copied in Step 1.
    * Click **OK**.

Your client is now set up to exclusively use your personal server.

## Managing Your Server Keys

Your server's identity is defined by its key pair (`id_ed25519` and `id_ed25519.pub`). These files are stored persistently in the addon's configuration directory. If you need to change them or restore from a backup, you have two methods:

* **Method 1 (Recommended): Replace the Files**
    1.  Stop the RustDesk Server addon.
    2.  Using Samba or File editor, navigate to the addon's config folder (`/addon_configs/1fe8b763_rustdesk_server`).
    3.  Delete the existing `id_ed25519` and `id_ed25519.pub` files.
    4.  Copy your new/backup key files into this directory.
    5.  Restart the addon.

* **Method 2 (Using Configuration):**
    1.  Open the addon's **Configuration** tab.
    2.  Paste the entire content of your public key file into the `Public Key` field.
    3.  Paste the entire content of your private key file into the `Private Key` field.
    4.  Save and restart the addon. The addon will use these provided keys instead of the ones in the file system.