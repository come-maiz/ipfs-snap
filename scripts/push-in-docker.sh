#!/bin/bash
#
# Push a snap to the store using a docker container.

set -ev

docker run -v $(pwd):$(pwd) -v $HOME:/root/ -t snapcore/snapcraft sh -c "apt update -qq && apt install snapcraft -y && cd $(pwd) && ls *.snap && for file in *.snap; do echo 'file: ' \$file && snapcraft push \$file --release edge; done"
