[![Travis](https://img.shields.io/travis/elopio/ipfs-snap.svg)](https://travis-ci.org/elopio/ipfs-snap/builds)

# ipfs-snap

IPFS is the Distributed Web, and this is its snap package.

## Install

To install the latest stable release:

    $ sudo snap install ipfs
    
To help testing the upcoming release:

    $ sudo snap install ipfs --edge

Note that this is an edge release, so it's available there only for brave early
adopters that would like to help testing it.

## Build

### In Ubuntu 16.04 or newer

Install snapcraft:

    $ sudo apt install snapcraft

Clone the repo:

    $ sudo apt install git
    $ git clone https://github.com/elopio/ipfs-snap
    $ cd ipfs-snap

Build the snap:

    $ snapcraft

Install it:

    $ sudo snap install ipfs*.snap --dangerous

### In archlinux

Install docker:

    $ sudo pacman -S docker
    $ sudo systemctl start docker
    $ sudo gpasswd -a $USER docker
    $ newgrp docker

Clone the repo:

    $ sudo packman -S git
    $ git clone https://github.com/elopio/ipfs-snap
    $ cd ipfs-snap

Build the snap in a docker container:

    $ docker run -v $(pwd):/cwd snapcore/snapcraft sh -c 'apt install software-properties-common wget -y && add-apt-repository -y ppa:gophers/archive && apt update && cd /cwd && snapcraft

Install snapd:

    $ sudo pacman -S snapd
    $ sudo systemctl enable --now snapd.socket


Install the built snap:

    $ sudo snap install ipfs*.snap --dangerous

## Try

    $ /snap/bin/ipfs init
