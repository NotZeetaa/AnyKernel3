# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Nexus Kernel
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=umi
supported.versions=11 - 15
supported.patchlevels=
'; } # end properties

# shell variables
block=boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;
no_block_display=1;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

case "$ZIPFILE" in
    *ksu*)
    ui_print " • Using KSU variant";
    rm Image;
    mv ksu/Image $home/Image;
    ;;
    *)
    ui_print " • Using normal variant";
    ;;
esac
    


## AnyKernel boot install
dump_boot;
flash_dtbo;

# begin ramdisk changes
# end ramdisk changes

write_boot;
## end boot install

# reset for vendor_boot patching
reset_ak;


## AnyKernel vendor_boot install
#split_boot; # skip unpack/repack ramdisk since we don't need vendor_ramdisk access

#flash_boot;
## end vendor_boot install
