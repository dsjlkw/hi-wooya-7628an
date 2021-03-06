#!/bin/sh
set -e -x

_version="$(printf "%s" "$REPO_BRANCH" | cut -c 2-)"
_vermagic="$(curl --retry 5 -L https://downloads.openwrt.org/releases/${_version}/targets/ramips/mt76x8/openwrt-${_version}-ramips-mt76x8.manifest | sed -e '/^kernel/!d' -e 's/^.*-\([^-]*\)$/\1/g' | head -n 1)"

OLD_CWD="$(pwd)"

[ "$(find build_dir/ -name .vermagic -exec cat {} \;)" = "$_vermagic" ] && \
mkdir ~/imb && \
tar -xJf bin/targets/ramips/mt76x8/openwrt-imagebuilder-${_version}-ramips-mt76x8.Linux-x86_64.tar.xz -C ~/imb && \
cd ~/imb/* && \
mkdir -p files && \
cp -r $GITHUB_WORKSPACE/files/* files/ && \
make image PROFILE=unielec_u7628-01-16m PACKAGES="kmod-usb-storage block-mount kmod-fs-ext4 luci luci-proto-qmi kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan kmod-usb-uhci kmod-usb-storage-uas kmod-usb-storage-extras luci-i18n-base-zh-cn" && \
mv bin/targets/ramips/mt76x8/openwrt-${_version}-ramips-mt76x8-unielec_u7628-01-16m-squashfs-sysupgrade.bin ../openwrt-${_version}-ramips-mt76x8-4g-unielec_u7628-01-16m-squashfs-sysupgrade.bin && \
make clean && \
mv ../*.bin "$OLD_CWD/bin/targets/ramips/mt76x8/"

cd "$OLD_CWD/bin/targets"/*/*
mv openwrt-imagebuilder-* openwrt-sdk-* ..
rm -rf packages
tar -c * | xz -z -e -9 -T 0 > "../$(grep -i "openwrt-.*-sysupgrade.bin" *sums | head -n 1 | cut -d "*" -f 2 | cut -d - -f 1-5)-firmware.tar.xz"
rm -rf *
xz -d -c ../openwrt-imagebuilder-* | xz -z -e -9 -T 0 > "$(basename ../openwrt-imagebuilder-*)"
xz -d -c ../openwrt-sdk-* | xz -z -e -9 -T 0 > "$(basename ../openwrt-sdk-*)"
mv ../*-firmware.tar.xz .
rm -f ../openwrt-imagebuilder-* ../openwrt-sdk-* *sums
sha256sum * > ../sha256sums
mv ../sha256sums .
