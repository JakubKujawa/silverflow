# ! The ARGs have default values, but changing those !
# ! does nothing if the image is built in the cloud. !

ARG IMAGE_MAJOR_VERSION="${IMAGE_MAJOR_VERSION:-38}"
ARG BASE_IMAGE_URL=ghcr.io/ublue-os/silverblue-main

FROM ${BASE_IMAGE_URL}:${IMAGE_MAJOR_VERSION}

ARG IMAGE_MAJOR_VERSION="${IMAGE_MAJOR_VERSION:-38}"

ARG RECIPE=silverflow-nvidia.yml

# The default image registry to write to policy.json and cosign.yaml
ARG IMAGE_REGISTRY=ghcr.io/ublue-os

COPY cosign.pub /usr/share/ublue-os/cosign.pub

# Copy the bling from ublue-os/bling into tmp, to be installed later by the bling module
COPY --from=ghcr.io/ublue-os/bling:latest /rpms /tmp/bling/rpms
COPY --from=ghcr.io/ublue-os/bling:latest /files /tmp/bling/files

# Copy build scripts & configuration
COPY build.sh /tmp/build.sh
COPY config /tmp/config/

# Copy modules
# The default modules are inside ublue-os/bling
COPY --from=ghcr.io/ublue-os/bling:latest /modules /tmp/modules/

# Custom modules overwrite defaults
COPY modules /tmp/modules/

# `yq` is used for parsing the yaml configuration
# It is copied from the official container image since it's not available as an RPM.
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

# ! Starting with F39, the main image does not contain kmods !
COPY --from=ghcr.io/ublue-os/akmods-nvidia:main-${FEDORA_MAJOR_VERSION} /rpms /tmp/rpms

# Run the build script, then clean up temp files and finalize container build.
RUN chmod +x /tmp/build.sh && /tmp/build.sh && rm -rf /tmp/* /var/* && ostree container commit
