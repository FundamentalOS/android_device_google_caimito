#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

# Inherit some common stuff
# FundamentalOS: ship Google Camera (GCam) instead of Aperture on this device
FUNDAMENTAL_SHIPS_GCAM := true

# FundamentalOS: drop AudioFX -- generic AOSP software effects only (no offload/DSP
# proxy on this Tensor audio config, so it is bypassed on compressed-offload playback),
# and it is a persistent privileged process. Gated by common_mobile_full.mk.
TARGET_EXCLUDES_AUDIOFX := true

$(call inherit-product, vendor/fundamental/config/common_full_phone.mk)

# Inherit device configuration
DEVICE_CODENAME := caiman
DEVICE_PATH := device/google/caimito
VENDOR_PATH := vendor/google/caiman
$(call inherit-product, $(DEVICE_PATH)/aosp_$(DEVICE_CODENAME).mk)

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 9 Pro
PRODUCT_NAME := fundamental_$(DEVICE_CODENAME)

# Boot animation
TARGET_SCREEN_HEIGHT := 2856
TARGET_SCREEN_WIDTH := 1280

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="caiman-user 16 BP4A.260205.002 14624737 release-keys" \
    BuildFingerprint=google/caiman/caiman:16/BP4A.260205.002/14624737:user/release-keys \
    DeviceProduct=$(DEVICE_CODENAME)

$(call inherit-product, $(VENDOR_PATH)/$(DEVICE_CODENAME)-vendor.mk)
