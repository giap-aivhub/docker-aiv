#!/usr/bin/env bash
[ "${DEBUG:-0}" -eq 0 ] || set -x
export VERSION=${VERSION:-1.0.0}

rm -rf aiv-${VERSION}
mkdir aiv-${VERSION}
cd aiv-${VERSION}
mkdir -p config/drivers repository/econfig repository/Config repository/images

# Copy necessary files
cp ../aiv.jar ./
cp -r ../config/drivers/* config/drivers/
cp -r ../repository/econfig/* repository/econfig/
cp -r ../repository/Config/* repository/Config/
cp -r ../repository/images/* repository/images/
mkdir debian
cp -r ../debian/* debian/ -av

# Build the package
dpkg-buildpackage -us -uc -b
