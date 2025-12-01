# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2013 OpenWrt.org

define Profile/Generic
  NAME:=Broadcom SoC, BCM43xx WiFi (b43, brcmfmac, default)
  PACKAGES:=kmod-b43 kmod-brcmfmac
endef

define Profile/Generic/Description
	Package set compatible with any hardware using Broadcom bcm47622...hopefully
endef

$(eval $(call Profile,Generic))

