#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/nothing/Tetris/device.mk)
$(call inherit-product, vendor/infinity/config/common_full_phone.mk)
TARGET_BOOT_ANIMATION_RES := 1080
INFINITY_MAINTAINER := "Baris"
TARGET_HAS_UDFPS := true
WITH_GAPPS := false
PRODUCT_NAME := infinity_Tetris
PRODUCT_DEVICE := Tetris
PRODUCT_BRAND := Nothing
PRODUCT_MANUFACTURER := Nothing
PRODUCT_MODEL := A015
PRODUCT_GMS_CLIENTID_BASE := android-nothing
DEVICE_CODENAME := Tetris
PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sys_mssi_64_64only_ww_armv82-user 16 BP2A.250605.031.A3 2606151652 release-keys" \
    BuildFingerprint=Nothing/Tetris/Tetris:16/BP2A.250605.031.A3/2606151652:user/release-keys \
    DeviceProduct=$(DEVICE_CODENAME) \
    DeviceName=$(DEVICE_CODENAME) \
    SystemDevice=$(DEVICE_CODENAME) \
    SystemName=$(DEVICE_CODENAME)
