#
# Copyright (C) 2008-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=drv_regopt
PKG_VERSION:=1.0
PKG_RELEASE:=1.0

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)
PKG_CHECK_FORMAT_SECURITY:=0

include $(INCLUDE_DIR)/package.mk

define KernelPackage/$(PKG_NAME)
  SUBMENU:=Other modules
  TITLE:=option the register
  FILES:=$(PKG_BUILD_DIR)/drv_regopt.ko
  AUTOLOAD:=$(call AutoLoad,50,trelay)
endef

define KernelPackage/$(PKG_NAME)/description
 This is a replacement for the following in-kernel drivers:
 1) 
 2) 

 Instead of generating input events (like in-kernel drivers do) it generates
 uevent-s and broadcasts them. This allows disabling input subsystem which is
 an overkill for OpenWrt simple needs.
endef


MAKE_OPTS:= \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	SUBDIRS="$(PKG_BUILD_DIR)"

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

include $(INCLUDE_DIR)/kernel-defaults.mk
define Build/Compile
	$(KERNEL_MAKE) M="$(PKG_BUILD_DIR)" modules
endef

$(eval $(call KernelPackage,$(PKG_NAME)))
