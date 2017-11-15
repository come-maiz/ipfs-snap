#!/bin/bash
#
# Build a snap.

set -ev

for arch in amd64 i386 armhf arm64; do
    snapcraft clean
    snapcraft --target-arch $arch
done
