#!/usr/bin/env bash

# you can also use the following command to build the package:
# docker run --rm -v "$(pwd)":/home/build/luci-app-nauta openwrtorg/sdk bash -c "../luci-app-nauta/build.sh"

./scripts/feeds update luci

make defconfig

./scripts/feeds install luci

cp -R ../luci-app-nauta/ package/feeds/luci/
mv package/feeds/luci/luci-app-nauta/makefiles/OpenWRT.Makefile package/feeds/luci/luci-app-nauta/Makefile

make package/luci-app-nauta/compile IGNORE_ERRORS=1 -j$(nproc) V=s

cp bin/packages/x86_64/luci/luci-app-nauta*.ipk ../luci-app-nauta/
