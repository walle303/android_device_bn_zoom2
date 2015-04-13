#
# Copyright (C) 2009 The Android Open Source Project
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
#
DEVICE_PACKAGE_OVERLAYS += device/bn/zoom2/overlay

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

# make cm build happy
PRODUCT_COPY_FILES += \
    device/bn/zoom2/prebuilt/boot/dummy.img:boot.img


# These are now copied using TARGET_RECOVERY_DEVICE_DIRS
#
#Recovery prorietaries:
#PRODUCT_COPY_FILES += \
#    device/bn/zoom2/recovery/sbin/bridged:/recovery/root/sbin/bridged \
#    device/bn/zoom2/recovery/sbin/cexec.out:/recovery/root/sbin/cexec.out \
#    device/bn/zoom2/recovery/sbin/omap-edpd.elf:/recovery/root/sbin/omap-edpd.elf \
#    device/bn/zoom2/recovery/sbin/libbridge.so:/recovery/root/sbin/libbridge.so \
#    device/bn/zoom2/recovery/sbin/refresh.sh:/recovery/root/sbin/refresh.sh \
#    device/bn/zoom2/recovery/etc/dsp/baseimage.dof:/recovery/root/etc/dsp/baseimage.dof \
#    device/bn/zoom2/recovery/etc/dsp/default_waveform.bin:/recovery/root/etc/dsp/default_waveform.bin \
#    device/bn/zoom2/recovery/etc/dsp/subframeip_snode_dsp.dll64P:/recovery/root/etc/dsp/subframeip_snode_dsp.dll64P \
#    device/bn/zoom2/recovery/etc/EpdWaveform:/recovery/root/etc/EpdWaveform

# Init files
PRODUCT_COPY_FILES += \
    device/bn/zoom2/init.rc:root/init.rc \
    device/bn/zoom2/init.zoom2.rc:root/init.zoom2.rc \
    device/bn/zoom2/init.zoom2.usb.rc:root/init.zoom2.usb.rc \
    device/bn/zoom2/ueventd.zoom2.rc:root/ueventd.zoom2.rc \
    device/bn/zoom2/fstab.zoom2:root/fstab.zoom2

PRODUCT_PACKAGES += \
    fsfinder \
    configure_vold.sh \
    store-mac-addr.sh

# key mapping and touchscreen files
PRODUCT_COPY_FILES += \
    device/bn/zoom2/prebuilt/usr/idc/zforce-ts.idc:/system/usr/idc/zForce_Touchscreen.idc 

#FIXME
#    device/bn/encore/prebuilt/usr/idc/ft5x06-i2c.idc:/system/usr/idc/ft5x06-i2c.idc \
#    device/bn/encore/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl





# PowerVR graphics driver configuration
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/etc/powervr.ini:system/etc/powervr.ini

PRODUCT_COPY_FILES += \
    hardware/ti/wlan/mac80211/firmware/127x/LICENCE:system/etc/firmware/ti-connectivity/LICENCE

PRODUCT_PACKAGES += \
    wl127x-fw-4-sr.bin \
    wl127x-fw-4-mr.bin \
    wl127x-fw-4-plt.bin \
    wl1271-nvs_127x.bin

# Script to edit the shipped nvs file to insert the device's assigned MAC
# address
PRODUCT_PACKAGES += store-mac-addr.sh

# Bluetooth
PRODUCT_COPY_FILES += \
    device/bn/zoom2/firmware/TIInit_7.2.31.bts:/system/etc/firmware/TIInit_7.2.31.bts


# include cicada's sensors library
common_ti_dirs := libsensors

include $(call all-named-subdir-makefiles, $(common_ti_dirs))

# Hardware capabilities
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/permissions/core_hardware.xml:system/etc/permissions/core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml

#    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml
#    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
#    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
#    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \

# Media Profile
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/etc/media_profiles.xml:system/etc/media_profiles.xml \
   $(LOCAL_PATH)/etc/media_codecs.xml:system/etc/media_codecs.xml

# Clears the boot counter
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/bin/clear_bootcnt.sh:/system/bin/clear_bootcnt.sh


ifeq ($(TARGET_PREBUILT_BOOTLOADER),)
    LOCAL_BOOTLOADER := device/bn/zoom2/prebuilt/boot/MLO
else
    LOCAL_BOOTLOADER := $(TARGET_PREBUILT_BOOTLOADER)
endif

ifeq ($(TARGET_PREBUILT_2NDBOOTLOADER),)
    LOCAL_2NDBOOTLOADER := device/bn/zoom2/prebuilt/boot/u-boot.bin
else
    LOCAL_2NDBOOTLOADER := $(TARGET_PREBUILT_2NDBOOTLOADER)
endif

ifeq ($(TARGET_PREBUILT_BOOTSCRIPT),)
    LOCAL_BOOTSCRIPT := device/bn/zoom2/prebuilt/boot/boot.scr
else
    LOCAL_BOOTSCRIPT := $(TARGET_PREBUILT_BOOTSCRIPT)
endif

# Boot files
PRODUCT_COPY_FILES += \
    $(LOCAL_BOOTLOADER):bootloader \
    $(LOCAL_2NDBOOTLOADER):2ndbootloader \
    $(LOCAL_BOOTSCRIPT):bootscript 


# ramdisk_tools.sh -- use on-demand for various ramdisk operations, such as
# repacking the ramdisk for use on an SD card or alternate emmc partitions
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/ramdisk_tools.sh:ramdisk_tools.sh

# additions to recovery
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

# XXX MAGIC: build process will delete any existing init.*.rc files from the
# recovery image, then copy this file from the main initramfs to the recovery
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/recovery/init.recovery.zoom2.rc:root/init.recovery.zoom2.rc

# Product specfic packages
PRODUCT_PACKAGES += \
    uim-sysfs \
    libbt-vendor \
    com.android.future.usb.accessory \
    dhcpcd.conf \
    dspexec \
    libCustomWifi \
    libbridge \
    libomap_mm_library_jni \
    librs_jni \
    libtiOsLib \
    make_ext4fs \
    lights.zoom2 \
    power.zoom2

#needs omapfb
#    hwcomposer.omap3 \


# OMX components
# Addition of LOCAL_MODULE_TAGS requires us to specify
# libraries needed for a particular device
PRODUCT_PACKAGES += \
    libI420colorconvert \
    libLCML \
    libOMX_Core \
    libOMX.TI.AAC.decode \
    libOMX.TI.AAC.encode \
    libOMX.TI.AMR.decode \
    libOMX.TI.AMR.encode \
    libOMX.TI.G711.decode \
    libOMX.TI.G711.encode \
    libOMX.TI.G722.decode \
    libOMX.TI.G722.encode \
    libOMX.TI.G726.decode \
    libOMX.TI.G726.encode \
    libOMX.TI.G729.decode \
    libOMX.TI.G729.encode \
    libOMX.TI.ILBC.decode \
    libOMX.TI.ILBC.encode \
    libOMX.TI.JPEG.decoder \
    libOMX.TI.JPEG.encoder \
    libOMX.TI.MP3.decode \
    libOMX.TI.Video.Decoder \
    libOMX.TI.Video.encoder \
    libOMX.TI.VPP \
    libOMX.TI.WBAMR.decode \
    libOMX.TI.WBAMR.encode \
    libOMX.TI.WMA.decode \
    libVendor_ti_omx

PRODUCT_PACKAGES += \
        libskiahw

# from omap3.mk.

PRODUCT_PACKAGES += \
	libdomx \
	libstagefrighthw \
	libion \
	smc_pa_ctrl \
	tf_daemon

PRODUCT_PACKAGES += \
	cexec.out

PRODUCT_CHARACTERISTICS := tablet


# Screen size is "large", density is "mdpi", need "hdpi" for extra drawables in 10.1
PRODUCT_AAPT_CONFIG := large mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Set property overrides
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=128m

$(call inherit-product-if-exists, vendor/bn/zoom2/zoom2-vendor.mk)

# Set property overrides
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-flags=m=y \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.allow.mock.location=1 \
    ro.setupwizard.enable_bypass=1 \
    keyguard.no_require_sim=1 \
    ro.opengles.version=131072 \
    ro.sf.widthpixels=600 \
    ro.sf.heightpixels=800 \
    ro.sf.lcd_density.xdpi=167 \
    ro.sf.lcd_density.ydpi=167 \
    opencore.asmd=1 \
    skia.jpeg_threshold=1024

