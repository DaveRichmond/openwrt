# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2013 OpenWrt.org

include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=bcm47622
BOARDNAME:=Broadcom BCM47622 (ARM)
FEATURES:=squashfs nand usb pci pcie gpio pwm
CPU_TYPE:=cortex-a7
SUBTARGETS:=generic

KERNEL_PATCHVER:=6.12

define Target/Description
	Build firmware images for Broadcom based BCM47622 routers with ARM CPU, *not* MIPS.
endef

include $(INCLUDE_DIR)/target.mk

KERNELNAME:=zImage dtbs

DEFAULT_PACKAGES += nvram \
	kmod-gpio-button-hotplug \
	kmod-leds-gpio

$(eval $(call BuildTarget))
