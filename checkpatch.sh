#!/bin/sh
set -e -x

[ "$(grep 'ALLWIFIBOARDS[ \t]*:=' package/firmware/ipq-wifi/Makefile | wc -l)" = 1 ]
[ "$(grep '$(eval $(call [^,]*,linksys_ea8300,[^)]*))' package/firmware/ipq-wifi/Makefile | wc -l)" = 1 ]
[ "$(grep '\*)' target/linux/ipq40xx/base-files/etc/board.d/01_leds | wc -l)" = 1 ]
[ "$(grep 'asus,rt-ac58u|' target/linux/ipq40xx/base-files/etc/board.d/02_network | wc -l)" = 1 ]
[ "$(grep 'asus,rt-ac58u)' target/linux/ipq40xx/base-files/etc/board.d/02_network | wc -l)" = 1 ]
[ "$(grep '"ath10k/pre-cal-pci-0000:01:00.0.bin")' target/linux/ipq40xx/base-files/etc/hotplug.d/firmware/11-ath10k-caldata | wc -l)" = 1 ]
[ "$(grep '8dev,jalapeno[ \t]*|' target/linux/ipq40xx/base-files/etc/hotplug.d/firmware/11-ath10k-caldata | wc -l)" = 2 ]
[ "$(grep '8dev,jalapeno[ \t]*|' target/linux/ipq40xx/base-files/lib/upgrade/platform.sh | wc -l)" = 1 ]
[ "$(grep 'qcom-ipq4019-a62.dtb' target/linux/ipq40xx/patches-5.4/901-arm-boot-add-dts-files.patch | wc -l)" = 1 ]
