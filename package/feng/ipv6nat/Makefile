#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ipv6-nat
PKG_VERSION:=1
PKG_RELEASE:=8
PKG_ARCH:=all

include $(INCLUDE_DIR)/package.mk

define Package/ipv6-nat
  CATEGORY:=feng
  TITLE:=ipv6-nat script.
  MAINTAINER:=feng
  DEPENDS:=+kmod-ipt-nat6 +odhcp6c
endef

define Package/ipv6-nat/description
ipv6-nat  automatically.
endef

define Build/Compile
endef

define Package/ipv6-nat/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/90-ipv6 $(1)/etc/hotplug.d/iface/90-ipv6
endef

$(eval $(call BuildPackage,ipv6-nat))
