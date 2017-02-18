#!/bin/bash
#
# Build a snap.

set -ev

snapcraft clean
snapcraft
