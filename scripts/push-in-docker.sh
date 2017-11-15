#!/bin/bash
#
# Push a snap to the store using a docker container.

set -ev

docker run -v $(pwd):$(pwd) -v $HOME:/root/ -t snapcore/snapcraft sh -c "apt update -qq && apt install snapcraft -y && cd $(pwd) && for arch in amd64 i386 armhf arm64; do snapcraft push *$arch.snap --release edge; done"
