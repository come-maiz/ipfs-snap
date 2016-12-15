#!/bin/bash
#
# Build a snap using a docker container.

set -ev

docker run -v "$(pwd)":/cwd snapcore/snapcraft sh -c "cd /cwd && ./scripts/snap.sh"
