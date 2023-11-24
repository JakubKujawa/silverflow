!include 100-bling.just
# Include some of your custom scripts here!

# Run the yafti setup tool
yafti:
    yafti /usr/share/ublue-os/firstboot/yafti.yml -f


# Install pdm (modern Python package and dependency manager) | https://pdm-project.org/latest/
install-pdm:
    #!/usr/bin/env bash
    cd ~/Downloads || exit
    curl -sSLO https://pdm-project.org/install-pdm.py
    curl -sSL https://pdm-project.org/install-pdm.py.sha256 | sha256sum -c -
    HOMEDIR=$( getent passwd "$USER" | cut -d: -f6 )
    python3 install-pdm.py --path "${HOMEDIR}/pdm"
    rm install-pdm.py