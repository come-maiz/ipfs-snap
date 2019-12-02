#!/bin/bash
#
# Build the ipfs snaps.

set -ev

# Check if the latest tag is in the beta channel.
tmp_dir="$(mktemp -d)"
source="$(cat snapcraft.yaml | grep source: | head -n 1 | awk '{printf $2}')"
wget --output-document=releases "https://api.github.com/repos/ipfs/go-ipfs/releases?client_id=$github_client_id&client_secret=$github_client_secret"
last_committed_tag="$(jq --raw-output .[0].tag_name releases)"
(snapcraft status ipfs || echo "none") > status
last_released_tag="$(cat status | grep beta | head -n1 | awk '{print $2}')"

if [ "${last_committed_tag}" != "${last_released_tag}" ]; then
    # Build using the latest tag.
    sed -i "0,/source-tag/s/source-tag:.*$/source-tag: '"$last_committed_tag"'/g" snapcraft.yaml
    sed -i "s/version:.*$/version: '"$last_committed_tag"'/g" snapcraft.yaml
fi

snapcraft
