#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from Tetris device
$(call inherit-product, device/nothing/Tetris/device.mk)

# Inherit some common Voltage stuff.
$(call inherit-product, vendor/voltage/config/common_full_phone.mk)

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1920

# Voltage Flags
TARGET_FACE_UNLOCK_SUPPORTED := true
EXTRA_UDFPS_ANIMATIONS := true

PRODUCT_NAME := voltage_Tetris
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
