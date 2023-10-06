#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

IMAGE_VENDOR=silverflow
IMAGE_TAG=latest
IMAGE_INFO=/usr/share/ublue-os/image-info.json

echo "Setting up container signing in policy.json and cosign.yaml for $IMAGE_NAME"
echo "Registry to write: $IMAGE_REGISTRY"

cp /usr/share/ublue-os/cosign.pub /usr/etc/pki/containers/"$IMAGE_NAME".pub

FILE=/usr/etc/containers/policy.json

yq -i -o=j '.transports.docker |=
    {"'"$IMAGE_REGISTRY"'/'"$IMAGE_NAME"'": [
            {
                "type": "sigstoreSigned",
                "keyPath": "/usr/etc/pki/containers/'"$IMAGE_NAME"'.pub",
                "signedIdentity": {
                    "type": "matchRepository"
                }
            }
        ]
    }
+ .' "$FILE"

IMAGE_REF="ostree-image-signed:docker://$IMAGE_REGISTRY/$IMAGE_NAME"

touch $IMAGE_INFO
cat >$IMAGE_INFO <<EOF
{
    "image-name": "$IMAGE_NAME",
    "image-flavor": "$BASE_IMAGE",
    "image-vendor": "$IMAGE_VENDOR",
    "image-ref": "$IMAGE_REF",
    "image-tag": "$IMAGE_TAG",
    "fedora-version": "$OS_VERSION"
}
EOF

sed -i '/^PRETTY_NAME/s/Silverblue/SilverFlow/' /usr/lib/os-release
cp /usr/etc/containers/registries.d/ublue-os.yaml /usr/etc/containers/registries.d/"$IMAGE_NAME".yaml
sed -i "s ghcr.io/ublue-os $IMAGE_REGISTRY g" /usr/etc/containers/registries.d/"$IMAGE_NAME".yaml
