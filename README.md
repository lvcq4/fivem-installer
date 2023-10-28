## FiveM Installer v2.0.0

Build: Latest recommended build

Operating System: Linux

### What's Included?

This installer provides the following components:

- FiveM Server artifacts
- cfx-server-data
- server.cfg
- ESX Framework (optional)
- MariaDB Server (optional)

### How to Install

Follow these steps to install FiveM on your system:

1. Navigate to a directory of your choice.
2. Install Git by running: `apt install git`
3. Clone this repository by executing: `git clone https://github.com/lvcq4/fivem-installer.git installer-script`
4. Change your working directory to the installer script: `cd installer-script`
5. Run the installation script: `./installer.sh`
6. Follow the on-screen prompts.
7. Once the installation is complete, you can remove the script by using: `rm installer.sh`, if desired.

### Contributors

- [lvcq4](https://github.com/lvcq4)

### Planned Future Updates

In future versions, we plan to include the following features:

- Option to integrate with txadmin.
  - If selected, you can choose to install a framework recommended by txadmin or upload your own.
  - If you opt to upload your own framework, you can select from different framework versions.
  - You can also choose to use the server.cfg from txadmin or the official one from fivem.net.
- If you don't have a database, the script will install a MySQL server, web server, and phpMyAdmin.
- Select different languages.
- Support for RedM in version 2.5.0.
  - The script may also offer the ability to install a RedM server.

Feel free to contribute to this project and stay tuned for [updates](https://github.com/lvcq4/fivem-installer/blob/main/changelog.txt)!
