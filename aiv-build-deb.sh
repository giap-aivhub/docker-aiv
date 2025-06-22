#!/usr/bin/env bash
[ "${DEBUG:-0}" -eq 0 ] || set -x

rm -rf aiv-6.3.4
mkdir aiv-6.3.4
cd aiv-6.3.4
mkdir -p config/drivers repository/econfig repository/Config repository/images
cp ../aiv.jar ./
cp -r ../config/drivers/* config/drivers/
cp -r ../repository/econfig/* repository/econfig/
cp -r ../repository/Config/* repository/Config/
cp -r ../repository/images/* repository/images/
mkdir debian
cp -r ../debian/* debian/ -av
# Build the package
dpkg-buildpackage -us -uc -b
