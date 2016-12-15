#!/bin/bash
#
# Push a snap to the store using a docker container.

set -ev

docker run -v $(pwd):$(pwd) -t snapcore/snapcraft sh -c "apt update -qq && apt install snapcraft -y && cd $(pwd) && snapcraft push *.snap --release edge"
