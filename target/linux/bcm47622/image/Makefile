# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2013 OpenWrt.org

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

DTS_DIR := $(DTS_DIR)/broadcom
IEEE8021X := wpad-basic-mbedtls
B43 := $(IEEE8021X) kmod-b43
USB2_PACKAGES := kmod-usb-ohci kmod-usb2 kmod-phy-bcm-ns-usb2
USB2_PACKAGES += kmod-usb-ledtrig-usbport
USB3_PACKAGES := $(USB2_PACKAGES) kmod-usb3 kmod-phy-bcm-ns-usb3

define Device/Default
  PROFILES = Generic $$(DEVICE_NAME)
  # .dtb files are prefixed by SoC type, e.g. bcm4708- which is not included in device/image names
  # extract the full dtb name based on the device info
  DEVICE_DTS := $(patsubst %.dtb,%,$(notdir $(wildcard $(if $(IB),$(KDIR),$(DTS_DIR))/*-$(subst _,-,$(1)).dtb)))
  KERNEL := kernel-bin | append-dtb | lzma-d16
  KERNEL_DEPENDS = $$(wildcard $(DTS_DIR)/$$(DEVICE_DTS).dts)
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma-d16
  FILESYSTEMS := squashfs
  KERNEL_NAME := zImage
  DEVICE_IMG_NAME = $$(DEVICE_IMG_PREFIX)-$$(1).$$(2)
  BLOCKSIZE := 128k
  PAGESIZE := 2048
endef

# aerohive 305c's have a bootloader that doesn't support fit images
# in order to netboot, we need to generate a fairly specific image
define Build/aeroimage
	cp $@ $@-rootfs.bin
	echo "DTS: $(DTS_DIR)/$(DEVICE_DTS).dtb"
	#mkimage -A arm -O Linux -T multi -C none -e $(KERNEL_ENTRY) -a $(KERNEL_LOADADDR) -n '$(VERSION_DIST) Linux-$(LINUX_VERSION)' -d $(KDIR)/zImage-initramfs:$@-rootfs.bin:$(DTS_DIR)/$(DEVICE_DTS).dtb $@
	mkimage -T multi -A arm -O linux -C none -a $(KERNEL_LOADADDR) -e $(KERNEL_ENTRY) -n "$(VERSION_DIST) Linux-$(LINUX_VERSION) - $(DEVICE_DTS)" -d $(KDIR)/zImage-initramfs:$@-rootfs.bin:$(DTS_DIR)/$(DEVICE_DTS).dtb $@
endef
define Device/aerohive_ap305c
  DEVICE_VENDOR := Aerohive
  DEVICE_MODEL := AP305c
  DEVICE_PACKAGES := $(B43)
  DEVICE_DTS := bcm47622-aerohive-ap305c
  #KCONFIG := CONFIG_ARCH_BCMBCA=y CONFIG_DEBUG_BCM63XX_UART=y
  KERNEL := kernel-bin | append-dtb | uImage none
  KERNEL_LOADADDR := 0x8000
  KERNEL_ENTRY := 0x8000
  #KERNEL_SUFFIX := -uImage.itb
  #KERNEL_INITRAMFS := kernel-bin | gzip | fit gzip $$(DTS_DIR)/$$(DEVICE_DTS).dtb
  KERNEL_INITRAMFS := kernel-bin | append-dtb | uImage none
  KERNEL_INITRAMFS_SUFFIX := .bin
  IMAGES := factory.ubi netboot.bin
  IMAGE/factory.ubi := append-ubi
  IMAGE/netboot.bin := append-rootfs | aeroimage
endef
TARGET_DEVICES += aerohive_ap305c

$(eval $(call BuildImage))
