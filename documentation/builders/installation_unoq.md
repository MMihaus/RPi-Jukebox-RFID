# Installing Phoniebox future3

> [!IMPORTANT]
> This is starting point for UNO Q specific installation guides
## Install clean Linux on UNO Q



Before you can install the Phoniebox software, you need to prepare your Raspberry Pi.



## Install Phoniebox software

Choose a version, run the corresponding install command in your SSH terminal and follow the instructions.

* [Stable Release](#stable-release)
* [Pre-Release](#pre-release)
* [Development](#development)

After a successful installation, [configure your Phoniebox](configuration.md).


### Stable Release

This will install the latest  from the *feat/unoq* branch.

```bash
cd; bash <(wget -qO- https://raw.githubusercontent.com/MMihaus/RPi-Jukebox-RFID/feat/unoq/installation/install-jukebox_unoq.sh)
```

### Pre-Release

This will install the latest **pre-release** from the *feat/unoq* branch.

```bash
cd; GIT_BRANCH='feat/unoq' bash <(wget -qO- https://raw.githubusercontent.com/MMihaus/RPi-Jukebox-RFID/feat/unoq/installation/install-jukebox_unoq.sh)
```

### Development

You can also install a specific branch and/or a fork repository. Update the variables to refer to your desired location. (The URL must not necessarily be updated, unless you have actually updated the file being downloaded.)

> [!IMPORTANT]
> A fork repository must be named '*RPi-Jukebox-RFID*' like the official repository

```bash
cd; GIT_USER='MiczFlor' GIT_BRANCH='future3/develop' bash <(wget -qO- https://raw.githubusercontent.com/MiczFlor/RPi-Jukebox-RFID/future3/develop/installation/install-jukebox.sh)
```

> [!NOTE]
> The Installation of the official repository's release branches ([Stable Release](#stable-release) and [Pre-Release](#pre-release)) will deploy a pre-build bundle of the Web App.
> If you install another branch or from a fork repository, the Web App needs to be built locally. This is part of the installation process. See the the developers [Web App](../developers/webapp.md) documentation for further details.

### Logs

To follow the installation closely, use this command in another terminal.

```bash
cd; tail -f INSTALL-<fullname>.log
```
