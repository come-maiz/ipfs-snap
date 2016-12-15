#!/bin/bash
#
# Build a snap.

set -ev

apt update
apt install software-properties-common -y
add-apt-repository -y ppa:gophers/archive
apt update
snapcraft clean
snapcraft
