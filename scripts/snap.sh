#!/bin/bash
#
# Build a snap.

set -ev

snap() {
    snapcraft clean
    ARCH_TRIPLET=$1 TARGET_GOARCH=$2 snapcraft --target-arch $3
}

snap x86_64-linux-gnu amd64 amd64
snap arm-linux-gnueabihf arm armhf
snap aarch64-linux-gnu arm64 arm64
