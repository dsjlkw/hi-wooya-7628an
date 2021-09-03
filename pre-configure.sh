#!/bin/sh
set -e -x
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

curl --retry 5 -L "https://downloads.openwrt.org/releases/21.02.0-rc4/targets/ramips/mt76x8/config.buildinfo" > .config
sed -e '/^CONFIG_TARGET_DEVICE_/d' -e '/CONFIG_TARGET_ALL_PROFILES=y/d' -i .config
cat "$GITHUB_WORKSPACE/additional_config.txt" >> .config
cat "$GITHUB_WORKSPACE/hi-wooya-7628an.dtsi" > target/linux/ramips/dts/mt7628an_unielec_u7628-01.dtsi

chmod +x "$GITHUB_WORKSPACE/checkpatch.sh"
"$GITHUB_WORKSPACE/checkpatch.sh"
chmod +x "$GITHUB_WORKSPACE/patch.sh"
"$GITHUB_WORKSPACE/patch.sh"

