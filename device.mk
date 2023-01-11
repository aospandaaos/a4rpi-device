# Copyright (C) 2021 Chris Simmonds, chris@2net.co.uk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# We are building a tablet
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)
PRODUCT_CHARACTERISTICS := tablet

#### Graphics ###

# OpenGLES version, one of:
# 131072 = 2.0
# 196608 = 3.0
# 196609 = 3.1
# 196610 = 3.2
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196609

PRODUCT_PROPERTY_OVERRIDES += \
    debug.drm.mode.force=1280x720 \
    gralloc.drm.kms=/dev/dri/card0 \
    gralloc.drm.device=/dev/dri/card1 \
    ro.hardware.vulkan=rpi4 \
    wifi.interface=wlan0 \
    ro.rfkilldisabled=1

PRODUCT_SOONG_NAMESPACES := external/mesa3d

# system packages
PRODUCT_PACKAGES += \
    gralloc.rpi4 \
    vulkan.broadcom \
    memtrack.rpi4 \
    audio.primary.rpi4 \
    audio.usb.default \
    audio.r_submix.default \
    wificond \
    wifilogd \
    wpa_supplicant \
    wpa_supplicant.conf \
    hostapd \
    libbt-vendor

# graphics hal
PRODUCT_PACKAGES += \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi

# Standard HALs
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.soundtrigger@2.3-impl

# Software Gatekeeper HAL
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl-cuttlefish \
    android.hardware.health@2.1-service

# PowerHAL
PRODUCT_PACKAGES += \
    android.hardware.power-service.example

# PowerStats HAL
PRODUCT_PACKAGES += \
    android.hardware.power.stats-service.example



# init configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.rpi4.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi4.rc \
    $(LOCAL_PATH)/init.rpi4.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi4.usb.rc \
    $(LOCAL_PATH)/ueventd.rpi4.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    $(LOCAL_PATH)/fstab.rpi4:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.rpi4 \
    $(LOCAL_PATH)/fstab.rpi4:$(TARGET_COPY_OUT_RAMDISK)/fstab.rpi4

# Broadcom firmware
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.bin:root/lib/firmware/brcm/brcmfmac43455-sdio.bin \
#    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.bin:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.bin \
#    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.clm_blob:root/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob \
#    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.clm_blob:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob \
#    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.txt:root/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt \
#    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.txt:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt \
#    $(LOCAL_PATH)/firmware/brcm/BCM4345C0.hcd:root/lib/firmware/brcm/BCM4345C0.hcd


# Files for boot.img
PRODUCT_COPY_FILES += \
    device/a4rpi/rpi4-kernel/Image.gz:kernel \
    $(LOCAL_PATH)/bcm2711-rpi-4-b.dtb:dtb.img

## Need AppWidget feature to prevent Launcher[2|3] crashing
#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml
#
