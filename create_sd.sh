#!/bin/bash

#Tunables:
SIZE=1600

# Create image
dd if=/dev/zero of=sd.img bs=1MiB count=${SIZE}
losetup /dev/loop0 sd.img
parted /dev/loop0 -s mklabel msdos
parted /dev/loop0 -s --align=cyl mkpart primary fat32 0 256MiB
parted /dev/loop0 -s set 1 boot on
parted /dev/loop0 -s --align=cyl mkpart primary ext3 256MiB 768MiB
parted /dev/loop0 -s --align=cyl mkpart primary ext3 768MiB 1024MiB
parted /dev/loop0 -s --align=cyl mkpart primary ext3 1024MiB 100%
#parted /dev/loop0 --align=cyl mkpart extended 1024MiB 100%
#parted /dev/loop0 --align=cyl mkpart logical ext3 1024MiB 100%
parted /dev/loop0 -s p
#losetup -d /dev/loop0
#losetup /dev/loop0 sd.img
#kpartx /dev/loop0

mkdosfs -F 32 -n "boot" /dev/loop0p1
mkfs.ext3 -L "system" /dev/loop0p2
mkfs.ext3 -L "cache" /dev/loop0p3
mkfs.ext3 -L "userdata" /dev/loop0p4

if [ ! -d "./tmpmount" ]; then
  mkdir "./tmpmount"
fi
mount -t vfat /dev/loop0p1 "./tmpmount"

cp "bootloader" "./tmpmount/MLO"
cp "2ndbootloader" "./tmpmount/u-boot.bin"
cp "kernel" "./tmpmount/uImage-recovery"
cp "ramdisk-recovery.ub" "./tmpmount/ramdisk-recovery.ub"

#copy dsp firmware, waveform, and stock images used by u-boot.
cp "../../../../device/bn/zoom2/prebuilt/boot/flash_spl.bin" "./tmpmount/"
cp "../../../../device/bn/zoom2/prebuilt/boot/wvf.bin" "./tmpmount/"
cp "../../../../device/bn/zoom2/prebuilt/boot/dead.pgm" "./tmpmount/"
cp "../../../../device/bn/zoom2/prebuilt/boot/booting.pgm" "./tmpmount/"
cp "../../../../device/bn/zoom2/prebuilt/boot/charging0.pgm" "./tmpmount/"
cp "../../../../device/bn/zoom2/prebuilt/boot/charging1.pgm" "./tmpmount/"
cp "../../../../device/bn/zoom2/prebuilt/boot/charging2.pgm" "./tmpmount/"
cp "../../../../device/bn/zoom2/prebuilt/boot/charging3.pgm" "./tmpmount/"

#copy twrp.scr, which is loaded on recovery keypress combo.
cp "../../../../device/bn/zoom2/prebuilt/boot/twrp.scr" "./tmpmount/twrp.scr"
#copy twrp.scr as boot.scr too, so twrp loads by default until OS is installed
cp "../../../../device/bn/zoom2/prebuilt/boot/twrp.scr" "./tmpmount/boot.scr"
sync
ls -l ./tmpmount
umount "./tmpmount"
rmdir ./tmpmount
sync
losetup -d /dev/loop0

echo "You can now flash sd.img to a SD card."


