#!/bin/bash

# Return failure as soon as a command fails to execute

set -e

cd "$(dirname "$0")"

# Tests included with the repository

pushd asm
./test.sh
popd

pushd link
./test.sh
popd

# Test some significant external projects that use RGBDS
# When adding new ones, don't forget to add them to the .gitignore!

export PATH="$PWD/..:$PATH"

if [ ! -d pokecrystal ]; then
	git clone https://github.com/pret/pokecrystal.git --shallow-since=2018-06-04 --single-branch
fi
pushd pokecrystal
git fetch
git checkout d96f914315c6ab82d30facbc4a5be1710f3c4a33
make clean
make -j4 compare
popd

if [ ! -d pokered ]; then
	git clone --recursive https://github.com/pret/pokered.git --shallow-since=2018-03-23 --single-branch
fi
pushd pokered
git fetch
git checkout 3e554e1d5206f0ede60f7e99e68637b7f13bc683
make clean
make -j4 compare
popd

if [ ! -d ucity ]; then
	git clone https://github.com/AntonioND/ucity.git --shallow-since=2017-07-13 --single-branch
fi
pushd ucity
git fetch
git checkout b0635f12553c2fae947fd91aa54d4caa602d8266
make clean
make -j4
popd
