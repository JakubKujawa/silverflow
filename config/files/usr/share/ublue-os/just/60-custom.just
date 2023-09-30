# Install JetBrains Toolbox | https://www.jetbrains.com/toolbox-app/
jetbrains-toolbox:
  #!/usr/bin/env bash
  @pushd "$(mktemp -d)"
  @echo "Get latest JetBrains Toolbox version"
  # Get the json with latest releases
  curl -sSfL -o releases.json "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
  # Extract information
  BUILD_VERSION=$(jq -r '.TBA[0].build' ./releases.json)
  DOWNLOAD_LINK=$(jq -r '.TBA[0].downloads.linux.link' ./releases.json)
  CHECKSUM_LINK=$(jq -r '.TBA[0].downloads.linux.checksumLink' ./releases.json)
  @echo "Installing JetBrains Toolbox ${BUILD_VERSION}"
  curl -sSfL -O "${DOWNLOAD_LINK}"
  curl -sSfL "${CHECKSUM_LINK}" | sha256sum -c
  tar zxf jetbrains-toolbox-"${BUILD_VERSION}".tar.gz
  @echo "Launching JetBrains Toolbox"
  ./jetbrains-toolbox-"${BUILD_VERSION}"/jetbrains-toolbox

# Run the yafti setup tool
yafti:
  yafti /usr/share/ublue-os/firstboot/yafti.yml -f
  
# Install mamba | https://github.com/conda-forge/miniforge
mamba:
  #!/usr/bin/env bash
  pushd "$(mktemp -d)"
  @echo "Get latest Miniforge3 version"
  curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
  HOMEDIR=$( getent passwd "$USER" | cut -d: -f6 )
  bash Miniforge3-$(uname)-$(uname -m).sh -b -p "${HOMEDIR}/mambaforge/"