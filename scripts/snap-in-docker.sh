#!/bin/bash
#
# Build a snap using a docker container.

set -ev

# Check if the latest tag is in the beta channel.
tmp_dir="$(mktemp -d)"
source="$(cat snapcraft.yaml | grep source: | head -n 1 | awk '{printf $2}')"
git clone "${source}" "${tmp_dir}"
last_committed_tag="$(git -C "${tmp_dir}" describe --tags --abbrev=0)"
docker run -v $(pwd):$(pwd) snapcore/snapcraft sh -c "apt update && apt install -y snapcraft && cd $(pwd) && ((snapcraft status ipfs || echo "none") > status)"
last_released_tag="$(cat status | grep beta | awk '{print $2}')"

if [ "${last_committed_tag}" != "${last_released_tag}" ]; then
    # Build using the latest tag.
    sed -i "s/source-tag:.*$/source-tag: '"$last_committed_tag"'/g" snapcraft.yaml
    sed -i "s/version:.*$/version: '"$last_commited_tag"'/g" snapcraft.yaml
fi

docker run -v "$(pwd)":/cwd snapcore/snapcraft sh -c "cd /cwd && ./scripts/snap.sh"
