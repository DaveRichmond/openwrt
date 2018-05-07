include $(TOPDIR)/rules.mk

PKG_NAME:=xr819
PKG_RELEASE=0

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_SOURCE_URL:=https://github.com/karabek/xradio.git
PKG_SOURCE_VERSION:=705c792d2d40544b884dab7796934502256a8fdd
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2018-05-03

PKG_MAINTAINER:=
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

XR819_AUTOLOAD := \
	cfg80211 \
	mac80211 \
	xradio_wlan

define KernelPackage/xr819
  SUBMENU:=Wireless Drivers
  TITLE:=xradio allwinner xr819 wireless driver
  DEPENDS:=+kmod-mac80211 +xr819-firmware
  FILES:=\
	  $(PKG_BUILD_DIR)/xradio_wlan.ko
  AUTOLOAD:=$(call AutoProbe,$(XR819_AUTOLOAD))
endef

NOSTDINC_FLAGS = \
		 -I$(PKG_BUILD_DIR) \
		 -I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
		 -I$(STAGING_DIR)/usr/include/mac80211-backport \
		 -I$(STAGING_DIR)/usr/include/mac80211/uapi \
		 -I$(STAGING_DIR)/usr/include/mac80211 \

EXTRA_KCONFIG:= \
	CONFIG_WLAN_VENDOR_XRADIO=m \
	CONFIG_XRADIO_USE_EXTENSIONS=y \
	CONFIG_XRADIO_WAPI_SUPPORT=n
EXTRA_CFLAGS:= \
        $(patsubst CONFIG_%, -DCONFIG_%=1, $(patsubst %=m,%,$(filter %=m,$(EXTRA_KCONFIG)))) \
        $(patsubst CONFIG_%, -DCONFIG_%=1, $(patsubst %=y,%,$(filter %=y,$(EXTRA_KCONFIG)))) 

MAKE_OPTS:= \
	$(KERNEL_MAKE_FLAGS) \
	NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
	SUBDIRS="$(PKG_BUILD_DIR)" \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	$(EXTRA_KCONFIG)

define Build/Compile
   $(MAKE) -C "$(LINUX_DIR)" \
	  $(MAKE_OPTS) \
	  modules
endef

define Package/xr819-firmware
  SECTION:=firmware
  CATEGORY:=Firmware
  TITLE:=Allwinner XR819 fimware
  DEPENDS:=+kmod-mac80211
endef

define Package/xr819-firmware/install
	$(INSTALL_DIR) $(1)/lib/firmware
	$(INSTALL_DIR) $(1)/lib/firmware/xr819
	$(CP) $(PKG_BUILD_DIR)/firmware/boot_xr819.bin $(1)/lib/firmware/xr819/
	$(CP) $(PKG_BUILD_DIR)/firmware/fw_xr819.bin $(1)/lib/firmware/xr819/
	$(CP) $(PKG_BUILD_DIR)/firmware/sdd_xr819.bin $(1)/lib/firmware/xr819/
endef

$(eval $(call BuildPackage,xr819-firmware))
$(eval $(call KernelPackage,xr819))

