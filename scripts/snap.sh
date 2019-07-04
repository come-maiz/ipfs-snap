#!/bin/bash
#
# Build the ipfs snaps.

set -ev

# Check if the latest tag is in the beta channel.
tmp_dir="$(mktemp -d)"
source="$(cat snapcraft.yaml | grep source: | head -n 1 | awk '{printf $2}')"
git clone "${source}" "${tmp_dir}"
last_committed_tag="$(git -C "${tmp_dir}" describe --tags --abbrev=0)"
(snapcraft status ipfs || echo "none") > status
last_released_tag="$(cat status | grep beta | head -n1 | awk '{print $2}')"

if [ "${last_committed_tag}" != "${last_released_tag}" ]; then
    # Build using the latest tag.
    sed -i "0,/source-tag/s/source-tag:.*$/source-tag: '"$last_committed_tag"'/g" snapcraft.yaml
    sed -i "s/version:.*$/version: '"$last_committed_tag"'/g" snapcraft.yaml
fi

snap() {
    snapcraft clean
    ARCH_TRIPLET=$1 TARGET_GOARCH=$2 snapcraft --target-arch $3
}

export GO111MODULE=on
snap x86_64-linux-gnu amd64 amd64
snap arm-linux-gnueabihf arm armhf
snap aarch64-linux-gnu arm64 arm64
