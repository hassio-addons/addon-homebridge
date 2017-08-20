#!/bin/bash
set -e

for arch in "armhf" "aarch64" "i386" "amd64"
do
    ./bin/build.sh -a $arch "$@" &
done
wait
