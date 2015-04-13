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

# This is a build configuration for a full-featured build of the
# Open-Source part of the tree. It's geared toward a US-centric
# build of the emulator, but all those aspects can be overridden
# in inherited configurations.


#Removed apps:
#PRODUCT_PACKAGES := \
#    libfwdlockengine \
#    WAPPushManager
#    Bluetooth \
#    Camera2 \
#    Music \
#    Email \
#    Exchange2 \
#    bluetooth-health \
##    Contacts \
#    PicoTts \


# Additional settings used in all AOSP builds
PRODUCT_PROPERTY_OVERRIDES := \
    ro.com.android.dateformat=MM-dd-yyyy

# Put en_US first in the list, so make it default.
PRODUCT_LOCALES := en_US

# Include drawables for all densities
PRODUCT_AAPT_CONFIG := normal 
#hdpi xhdpi xxhdpi

# Get a list of languages.
PRODUCT_LOCALES := en_US en_GB fr_FR it_IT de_DE es_ES

#try mid (mobile internet device?) because nook isn't a phone
PRODUCT_POLICY := android.policy_mid

PRODUCT_PACKAGES := \
    DeskClock \
    Calculator \
    Calendar \
    CertInstaller \
    FusedLocation \
    Gallery2 \
    InputDevices \
    Keyguard \
    LatinIME \
    Launcher2 \
    OneTimeInitializer \
    PrintSpooler \
    Provision \
    Settings \
    SystemUI \
    TeleService \
    CalendarProvider \
    hostapd \
    wpa_supplicant.conf \
    WallpaperCropper \

PRODUCT_PACKAGES += \
    clatd \
    clatd.conf \
    dhcpcd.conf \
    network \
    pand \
    pppd \
    sdptool \
    wpa_supplicant

PRODUCT_PACKAGES += \
    librs_jni

PRODUCT_PACKAGES += \
    local_time.default \
    power.default

PRODUCT_PACKAGES += \
    local_time.default

PRODUCT_COPY_FILES := \
        frameworks/av/media/libeffects/data/audio_effects.conf:system/etc/audio_effects.conf

PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=unknown

$(call inherit-product-if-exists, frameworks/base/data/fonts/fonts.mk)
$(call inherit-product-if-exists, external/noto-fonts/fonts.mk)
$(call inherit-product-if-exists, external/naver-fonts/fonts.mk)
$(call inherit-product-if-exists, external/sil-fonts/fonts.mk)
$(call inherit-product-if-exists, frameworks/base/data/keyboards/keyboards.mk)
$(call inherit-product-if-exists, frameworks/webview/chromium/chromium.mk)

PRODUCT_PACKAGES += \
    BasicDreams \
    Browser \
    DocumentsUI \
    DownloadProviderUi \
    ExternalStorageProvider \
    KeyChain \
    PacProcessor \
    ProxyHandler \
    SharedStorageBackup \
    VpnDialogs

PRODUCT_PACKAGES += \
    ContactsProvider \
    DefaultContainerService \
    TelephonyProvider \
    UserDictionaryProvider \
    atrace \
    libandroidfw \
    libaudiopreprocessing \
    libaudioutils \
    libbcc \
    libfilterpack_imageproc \
    libgabi++ \
    libkeystore \
    libmdnssd \
    libnfc_ndef \
    libportable \
    libpowermanager \
    libspeexresampler \
    libstagefright_chromium_http \
    libstagefright_soft_aacdec \
    libstagefright_soft_aacenc \
    libstagefright_soft_amrdec \
    libstagefright_soft_amrnbenc \
    libstagefright_soft_amrwbenc \
    libstagefright_soft_flacenc \
    libstagefright_soft_g711dec \
    libstagefright_soft_gsmdec \
    libstagefright_soft_h264dec \
    libstagefright_soft_h264enc \
    libstagefright_soft_mp3dec \
    libstagefright_soft_mpeg4dec \
    libstagefright_soft_mpeg4enc \
    libstagefright_soft_rawdec \
    libstagefright_soft_vorbisdec \
    libstagefright_soft_vpxdec \
    libstagefright_soft_vpxenc \
    libvariablespeed \
    libwebrtc_audio_preprocessing \
    mdnsd \
    mms-common \
    requestsync \
    screenrecord \
    telephony-common \
    voip-common \
    telephony-msim

PRODUCT_PACKAGES += \
    aapt \
    BackupRestoreConfirmation \
    DownloadProvider \
    HTMLViewer \
    MediaProvider \
    PackageInstaller \
    SettingsProvider \
    Shell \
    bu \
    com.android.location.provider \
    com.android.location.provider.xml \
    com.android.media.remotedisplay \
    com.android.media.remotedisplay.xml \
    drmserver \
    framework-res \
    idmap \
    installd \
    ip \
    ip-up-vpn \
    ip6tables \
    iptables \
    keystore \
    keystore.default \
    libOpenMAXAL \
    libOpenSLES \
    libdownmix \
    libdrmframework \
    libdrmframework_jni \
    libfilterfw \
    libsqlite_jni \
    libwilhelm \
    make_ext4fs \
    screencap \
    sensorservice \
    uiautomator \
    uncrypt

PRODUCT_BOOT_JARS := core:conscrypt:okhttp:core-junit:bouncycastle:ext:framework:framework2:android.policy:services:apache-xml:webviewchromium

PRODUCT_RUNTIMES := runtime_libdvm_default
PRODUCT_RUNTIMES += runtime_libart

PRODUCT_PACKAGES += \
    20-dns.conf \
    95-configured \
    am \
    android.policy \
    android.test.runner \
    app_process \
    applypatch \
    blkid \
    bmgr \
    bugreport \
    content \
    dhcpcd \
    dhcpcd-run-hooks \
    dnsmasq \
    framework \
    fsck_msdos \
    ime \
    javax.obex \
    libSR_AudioIn \
    libandroid \
    libandroid_runtime \
    libandroid_servers \
    libaudioeffect_jni \
    libaudioflinger \
    libbundlewrapper \
    libcamera_client \
    libcameraservice \
    libdl \
    libeffectproxy \
    libeffects \
    libinput \
    libiprouteutil \
    libjni_latinime \
    libjnigraphics \
    libldnhncr \
    libmedia \
    libmedia_jni \
    libmediaplayerservice \
    libmtp \
    libnetlink \
    libnetutils \
    libpac \
    libreference-ril \
    libreverbwrapper \
    libril \
    librtp_jni \
    libsensorservice \
    libskia \
    libsonivox \
    libsoundpool \
    libsqlite \
    libstagefright \
    libstagefright_amrnb_common \
    libstagefright_avc_common \
    libstagefright_enc_common \
    libstagefright_foundation \
    libstagefright_omx \
    libstagefright_yuv \
    libusbhost \
    libutils \
    libvisualizer \
    libvorbisidec \
    libwpa_client \
    media \
    media_cmd \
    mediaserver \
    monkey \
    mtpd \
    ndc \
    netcfg \
    netd \
    ping \
    ping6 \
    platform.xml \
    pppd \
    pm \
    racoon \
    run-as \
    schedtest \
    screenshot \
    sdcard \
    services \
    settings \
    svc \
    tc \
    vdc \
    vold \
    webview \
    wm

PRODUCT_PACKAGES += \
    adb \
    adbd \
    bootanimation \
    debuggerd \
    dumpstate \
    dumpsys \
    gralloc.default \
    gzip \
    healthd \
    init \
    init.environ.rc \
    init.rc \
    input \
    libEGL \
    libETC1 \
    libFFTEm \
    libGLES_android \
    libGLESv1_CM \
    libGLESv2 \
    libbinder \
    libc \
    libctest \
    libcutils \
    libdl \
    libgui \
    libhardware \
    libhardware_legacy \
    libjpeg \
    liblog \
    libm \
    libpixelflinger \
    libpower \
    libstdc++ \
    libstlport \
    libsurfaceflinger \
    libsurfaceflinger_ddmconnection \
    libsysutils \
    libthread_db \
    libui \
    libutils \
    linker \
    logcat \
    logwrapper \
    reboot \
    service \
    servicemanager \
    surfaceflinger \
    toolbox

# SELinux packages
PRODUCT_PACKAGES += \
    auditd \
    sepolicy \
    file_contexts \
    seapp_contexts \
    property_contexts \
    mac_permissions.xml


PRODUCT_COPY_FILES += \
    system/core/rootdir/init.usb.rc:root/init.usb.rc \
    system/core/rootdir/init.trace.rc:root/init.trace.rc \
    system/core/rootdir/ueventd.rc:root/ueventd.rc \
    system/core/rootdir/etc/hosts:system/etc/hosts

# Override the PRODUCT_BOOT_JARS set in core_minimal.mk
PRODUCT_BOOT_JARS := core:conscrypt:okhttp:core-junit:bouncycastle:ext:framework:framework2:telephony-common:voip-common:mms-common:android.policy:services:apache-xml:webviewchromium:telephony-msim

