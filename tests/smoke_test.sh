#!/bin/bash

set -ex

ipfs=/snap/bin/ipfs

script_path="$(dirname "$0")"

# Check the version.
$ipfs version | grep "^ipfs version .*$"

# Init the repo.
$ipfs init

# Show the readme.
$ipfs cat /ipfs/QmVLDAhCY3X9P2uRudKAryuQFPM5zqA3Yij1dY8FpGbL7T/readme | grep -z "^Hello and Welcome to IPFS!.*$"

# Start the daemon.
$ipfs daemon &

# Check the peers.
sleep 30
$ipfs swarm peers | grep -E "ip4|ip6"

# Get an object from the network.
$ipfs cat /ipfs/QmW2WQi7j6c7UgJTarActp7tDNikE4B2qXtFCfLPdsgaTQ/cat.jpg > cat.jpg
diff cat.jpg "$script_path/data/expected_cat.jpg"

# Put an object in the network.
hash=`echo "I <3 IPFS snap-test-$(uuidgen)" | $ipfs add -q`
curl "http://localhost:8080/ipfs/$hash" | grep "^I <3 IPFS snap-test-.*$"
