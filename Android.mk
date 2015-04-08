ifeq ($(TARGET_BOOTLOADER_BOARD_NAME),zoom2)
include $(call first-makefiles-under,$(call my-dir))

LOCAL_PATH := $(call my-dir)

endif
