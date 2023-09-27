# SilverFlow (Fedora SilverBlue with Nvidia from [uBlue-OS](https://github.com/ublue-os/nvidia), WIP)

[![build-ublue](https://github.com/JakubKujawa/silverflow/actions/workflows/build.yml/badge.svg)](https://github.com/JakubKujawa/silverflow/actions/workflows/build.yml)

## Installation

> **Warning**
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:

  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/jakubkujawa/silverflow:latest
  ```

- Reboot to complete the rebase:

  ```
  systemctl reboot
  ```

- Then rebase to the signed image, like so:

  ```
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/jakubkujawa/silverflow:latest
  ```

- Reboot again to complete the installation

  ```
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/jakubkujawa/silverflow:20230403
```


## uBlue Documentation


- [Main website and documentation](https://universal-blue.org)
- [Documentation for these images](https://universal-blue.org/images/nvidia)
- [Installation](https://universal-blue.org/installation/) - follow this for clean installation
- [Rebase instructions](https://universal-blue.org/images/) - follow this if you want to switch to another image.