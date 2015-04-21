# inherit from the proprietary version
-include vendor/bn/zoom2/BoardConfigVendor.mk

TARGET_BOOTLOADER_BOARD_NAME := zoom2
TARGET_BOARD_PLATFORM := omap3

# Target configuration (architecture/platform/board)
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a8
ARCH_ARM_HAVE_ARMV7A := true

COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP3 -DOMAP_ENHANCEMENT_CPCAM

TARGET_SPECIFIC_HEADER_PATH := device/bn/zoom2/include

#Low Ram Settings:
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.jit.codecachesize=0

#FIXME are these still used?
TARGET_CPU_VARIANT := cortex-a8
PRODUCT_CHARACTERISTICS := tablet

ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp 
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp 

TARGET_PROVIDES_INIT_RC := true
TARGET_PROVIDES_INIT_TARGET_RC := true


#releasetools
TARGET_PROVIDES_RELEASETOOLS := true
TARGET_RELEASETOOL_IMG_FROM_TARGET_SCRIPT := ./device/bn/zoom2/releasetools/zoom2_img_from_target_files
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := ./device/bn/zoom2/releasetools/zoom2_ota_from_target_files
TARGET_CUSTOM_RELEASETOOL := ./device/bn/zoom2/releasetools/squisher
TARGET_SYSTEMIMAGE_USE_SQUISHER := true

#kernel image configuration
BOARD_KERNEL_CMDLINE :=androidboot.console=ttyO1,115200n8 root=/dev/ram rw init=/init vram=16M video=omap3epfb:mode=800x600x16x14x270x0,pmic=tps65180-1p2-i2c,vcom=-1990
BOARD_KERNEL_BASE := 0x20000000
BOARD_KERNEL_IMAGE_NAME := uImage
BOARD_PAGE_SIZE := 0x00000800
BOARD_CUSTOM_BOOTIMG_MK := device/bn/zoom2/uboot-bootimg.mk
# Include a 2ndbootloader
TARGET_BOOTLOADER_IS_2ND := true

# Inline kernel building
TARGET_KERNEL_SOURCE := kernel/bn/zoom2
TARGET_KERNEL_CONFIG := gossamer_defconfig
#newer gcc causes kernel panic on unaligned mem access... FIXME
TARGET_KERNEL_CUSTOM_TOOLCHAIN := ../../../prebuilt/linux-x86/toolchain/arm-eabi-4.4.3

TARGET_MODULES_SOURCE := "hardware/ti/wlan/mac80211/compat_wl12xx"

wifi_modules:
	make -C $(TARGET_MODULES_SOURCE) KERNEL_DIR=$(KERNEL_OUT) KLIB=$(KERNEL_OUT) KLIB_BUILD=$(KERNEL_OUT) ARCH=$(TARGET_ARCH) $(ARM_CROSS_COMPILE)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/net/mac80211/mac80211.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/net/wireless/cfg80211.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx_sdio.ko $(KERNEL_MODULES_OUT)
	$(ARM_EABI_TOOLCHAIN)/arm-eabi-strip --strip-debug $(KERNEL_MODULES_OUT)/mac80211.ko $(KERNEL_MODULES_OUT)/cfg80211.ko $(KERNEL_MODULES_OUT)/wl12xx.ko $(KERNEL_MODULES_OUT)/wl12xx_sdio.ko

TARGET_KERNEL_MODULES := wifi_modules

# Conserve memory in the Dalvik heap
# Details: https://github.com/CyanogenMod/android_dalvik/commit/15726c81059b74bf2352db29a3decfc4ea9c1428
TARGET_ARCH_LOWMEM := true

# HW Graphics (EGL fixes + webkit fix)
BOARD_EGL_CFG := device/bn/zoom2/egl.cfg
USE_OPENGL_RENDERER := false
ENABLE_WEBGL := false

TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

# for frameworks/native/opengl/libs
# disable use of unsupported EGL_KHR_gl_colorspace extension
BOARD_EGL_WORKAROUND_BUG_10194508 := true

# for frameworks/native/libs/gui
# disable use of EGL_KHR_fence_sync extension, since it slows things down
COMMON_GLOBAL_CFLAGS += -DDONT_USE_FENCE_SYNC

# for frameworks/native/services/surfaceflinger
# use EGL_IMG_context_priority extension, which helps performance
COMMON_GLOBAL_CFLAGS += -DHAS_CONTEXT_PRIORITY

# OMAP3 HWC: disable use of YUV overlays
# Prevents stuttering/compositing artifacts and sync loss during video playback
TARGET_OMAP3_HWC_DISABLE_YUV_OVERLAY := true

# Storage
BOARD_VOLD_MAX_PARTITIONS := 16
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/class/android_usb/android0/f_mass_storage/lun%d/file"

# Connectivity - Wi-Fi
USES_TI_MAC80211 := true
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X_TI
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_WLAN_DEVICE                := wl12xx_mac80211
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wl12xx_sdio.ko"
WIFI_DRIVER_MODULE_NAME          := "wl12xx_sdio"
WIFI_FIRMWARE_LOADER             := ""
COMMON_GLOBAL_CFLAGS             += -DUSES_TI_MAC80211
BOARD_WIFI_SKIP_CAPABILITIES     := true

# MultiMedia defines
USE_CAMERA_STUB := true
BOARD_USES_TI_OMAP_MODEM_AUDIO := false
HARDWARE_OMX := true

# Boot animation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_BOOTANIMATION_USE_RGB565 := true

#system image configuration
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 536870912 #512Mb, room to grow
#Old: 292438016 #292438016 # made multiple of 4096 - old 292436992
BOARD_USERDATAIMAGE_PARTITION_SIZE := 827691008
BOARD_CACHEIMAGE_PARTITION_SIZE := 243698688
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

#no radio 
TARGET_NO_RADIOIMAGE := true

#Config for building TWRP
# Recovery options
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/bn/zoom2/recovery/recovery_keys.c
BOARD_CUSTOM_RECOVERY_UI := ../../device/bn/zoom2/recovery/recovery_ui.c
TARGET_RECOVERY_PRE_COMMAND := "/system/bin/mount -t vfat -o sync,noatime,umask=0077 /dev/block/mmcblk0p2 /rom; /system/bin/dd if=/dev/zero of=/rom/bcb bs=64 count=1 > /dev/null 2>&1 ; echo 'recovery' >> /rom/bcb ; /system/bin/sync"
TARGET_RECOVERY_FSTAB := device/bn/zoom2/fstab.zoom2
RECOVERY_FSTAB_VERSION := 2
TARGET_RECOVERY_INITRC := device/bn/zoom2/recovery/init.recovery.rc
DEVICE_RESOLUTION := 480x800
RECOVERY_TOUCHSCREEN_SWAP_XY := false
#RECOVERY_TOUCHSCREEN_FLIP_Y := false
TARGET_RECOVERY_DEVICE_DIRS += device/bn/zoom2
TW_NO_REBOOT_BOOTLOADER := true
TW_NO_REBOOT_RECOVERY := true
TW_INTERNAL_STORAGE_PATH := "/emmc"
TW_INTERNAL_STORAGE_MOUNT_POINT := "emmc"
TW_EXTERNAL_STORAGE_PATH := "/sdc"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdc"

#debug
#TWRP_EVENT_LOGGING := true

#FIXME?
#BOARD_HAS_LARGE_FILESYSTEM := false
#BOARD_RECOVERY_IGNORE_BOOTABLES := true
BOARD_USES_GENERIC_AUDIO := false
BOARD_HAVE_FAKE_GPS := true
USE_CAMERA_STUB := true
BOARD_HAS_NO_MISC_PARTITION := true

