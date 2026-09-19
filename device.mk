#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    com.android.hardware.boot \
    android.hardware.boot-service.default_recovery

PRODUCT_PACKAGES += \
    create_pl_dev \
    create_pl_dev.recovery

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

# API
BOARD_SHIPPING_API_LEVEL := 34
PRODUCT_SHIPPING_API_LEVEL := 34

# Audio
$(call soong_config_set_bool,android_hardware_audio,skip_speaker_layout_channel_mask_field,true)

PRODUCT_PACKAGES += \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \
    android.hardware.bluetooth.audio-V3-ndk.vendor \
    android.hardware.soundtrigger@2.3-impl

PRODUCT_PACKAGES += \
    audio.primary.default \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default \
    libtinycompress

PRODUCT_PACKAGES += \
    MtkInCallService

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_configuration_a2dp_offload_enable_cg_enable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/le_audio_codec_capabilities.xml:$(TARGET_COPY_OUT_VENDOR)/etc/le_audio_codec_capabilities.xml \
    $(LOCAL_PATH)/configs/audio/usb_audio_accessory_only_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_accessory_only_policy_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-com.android.hotwordenrollment.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-com.android.hotwordenrollment.xml

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_with_le_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_with_le_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth-service.mediatek

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml

# Boot animation
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2400

# Camera
PRODUCT_PACKAGES += \
    libcamera_metadata_shim \
    libmtk_cam_shim_Tetris \
    libprocessgroup_shim

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.concurrent.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.concurrent.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml

# Display
PRODUCT_PACKAGES += \
    android.hardware.memtrack-service.mediatek \
    libui_shim

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2022-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2022-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Dolby
$(call inherit-product, hardware/dolby/dolby.mk)

PRODUCT_PACKAGES += \
        DolbyAtmos

# Doze
PRODUCT_PACKAGES += \
    NothingDoze

# DRM
PRODUCT_PACKAGES += \
    com.android.hardware.drm.clearkey

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Fingerprint
$(call soong_config_set_bool,surfaceflinger,has_mtk_udfps,true)
$(call soong_config_set,surfaceflinger,mtk_dim_layer,NTFingerprintDimLayer)

PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.nothing

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# GNSS
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.mediatek \
    android.hardware.health-service.mediatek-recovery

$(call soong_config_set,lineage_health,charging_control_charging_path,/proc/charger/usb_charger_en)

PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

# Init
PRODUCT_PACKAGES += \
    chipinfo \
    fstab.enableswap \
    fstab.mt6878 \
    fstab.mt6878.vendor_ramdisk \
    fstab.postinstall_avb \
    init_conninfra.rc \
    init.connectivity.common.rc \
    init.mt6878.rc \
    init.mt6878.power.rc \
    init.mt6878.usb.rc \
    init.mtkgki.rc \
    init.nothing.hw.rc \
    init.project.rc \
    init.sensor_2_0.rc \
    ueventd.mt6878.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.recovery.mt6878.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt6878.rc

# ION
$(call soong_config_set_bool,libion,legacy_impl,true)

# Kernel
$(call inherit-product, device/nothing/Tetris-kernel/kernel.mk)

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore_V2.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay-service.sysfs

$(call soong_config_set_bool,livedisplay_sysfs,enable_se,true)
$(call soong_config_set,livedisplay_sysfs,se_path,/sys/panel_feature/hbm_mode)

# Media
PRODUCT_PACKAGES += \
    android.hardware.media.bufferpool2-V2-ndk.vendor \
    libstagefright_aidl_bufferpool2.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_codecs_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml

# Net
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.ipsec_tunnel_migration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnel_migration.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

# Linker config
PRODUCT_VENDOR_LINKER_CONFIG_FRAGMENTS += \
    $(LOCAL_PATH)/configs/linker.config.json

# NTF
PRODUCT_PACKAGES += \
    nt-fwk.Tetris

PRODUCT_BOOT_JARS += \
    nt-fwk.Tetris

# Overlays
$(call inherit-product, hardware/mediatek/overlay/mssi.mk)

PRODUCT_PACKAGES += \
    NothingCarrierConfigResTarget \
    NothingFrameworksResTarget \
    NothingLauncher3ResTarget \
    NothingSettingsResTarget \
    NothingSystemUIResTarget

PRODUCT_PACKAGES += \
    NcmTetheringOverlay

PRODUCT_PACKAGES += \
    SettingsResTarget \
    SystemUIResTarget

# Page size
PRODUCT_NO_BIONIC_PAGE_SIZE_MACRO := true

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    android.hardware.fastboot-service.example_recovery \
    fastbootd

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr \
    vendor.mediatek.hardware.mtkpower@1.2-service.stub

PRODUCT_PACKAGES += \
    libmtkperf_client_vendor \
    libpowerhalwrap_vendor \
    libmtkperf_client

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Properties
include hardware/mediatek/configs/properties/vendor_logtag.mk

# Radio
ENABLE_VENDOR_RIL_SERVICE := true

PRODUCT_PACKAGES += \
    mdota_symlink

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/skus/,$(TARGET_COPY_OUT_ODM)/etc)

# Radio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-com.mediatek.ims.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-com.mediatek.ims.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-com.mediatek.telephony.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-com.mediatek.telephony.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml

# Security
BOOT_SECURITY_PATCH := 2026-04-05
INIT_BOOT_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := 2026-04-05

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.multihal \
    android.hardware.sensors@2.0-subhal-impl-1.0 \
    sensors.nothing

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel/pixelstats \
    hardware/google/pixel/power-libperfmgr \
    hardware/google/pixel/thermal \
    hardware/mediatek \
    hardware/mediatek/libmtkperf_client

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.mediatek

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal/thermal_info_config.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json

# USB
$(call soong_config_set_bool,android_hardware_mediatek_usb,audio_accessory_supported,true)

PRODUCT_PACKAGES += \
    android.hardware.usb-service.mediatek \
    android.hardware.usb.gadget-service.mediatek

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# Verified boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator.service.Tetris-richtap

# VNDK
PRODUCT_PACKAGES += \
    vndservicemanager

# Wifi
$(call soong_config_set_bool,mediatek_wifi_hal,use_pre_u_qpr2_struct,true)

PRODUCT_PACKAGES += \
    wpa_supplicant \
    hostapd \
    android.hardware.wifi-service \
    wlan_assistant

PRODUCT_PACKAGES += \
    libwifi-hal-wrapper

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml

# Inherit the proprietary files makefile
$(call inherit-product, vendor/nothing/Tetris/Tetris-vendor.mk)
