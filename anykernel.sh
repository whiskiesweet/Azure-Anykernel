#!/sbin/sh

properties() {
kernel.string=""
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=1
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
}

BLOCK=boot;
IS_SLOT_DEVICE=auto;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

. tools/ak3-core.sh;

check_kernel_base() {
    _proc_ver=$(cat /proc/version 2>/dev/null)
    if [ -z "$_proc_ver" ]; then
        abort "Error: Gagal membaca /proc/version."
    fi
    
    _running=$(echo "$_proc_ver" | awk '{print $3}')
    
    if ! echo "$_proc_ver" | grep -q "Linux version 5\.10\."; then
        abort "Error: This kernel is for a 5.10 base only! Detected:: ${_running}."
    fi
    ui_print "  -> Base kernel verified: ${_running}"
}

check_kernel_base;

split_boot;

flash_boot;
