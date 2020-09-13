#!/system/bin/sh
# Copyright (c) 2015 Sony Mobile Communications Inc.
# All rights, including trade secret rights, reserved.
#
# Used to handle FOTA related actions at post-fs-data

# Remove FOTA package on internal sdcard. This is needed
# to avoid SE-Linux vioation.
if [ -e /cache/recovery/fota/executed ]; then
    if [ -e /data/media/0/recovery/update_package ]; then
        rm /data/media/0/recovery/update_package
    fi
fi

# Copy FOTA status files from cache to internal sdcard
# This is needed for FOTA services that are not platform_app
# and cannot access cache due to SE-Linux.
if [ -e /cache/recovery/fota/status ]; then
    if [ ! -d /data/media/0/recovery ]; then
        mkdir -m 775 /data/media/0/recovery
        chown media_rw:media_rw /data/media/0/recovery
    fi
    cp /cache/recovery/fota/status /data/media/0/recovery/status
    chown media_rw:media_rw /data/media/0/recovery/status
    chmod 664 /data/media/0/recovery/status
fi
if [ -e /cache/recovery/fota/shortreport ]; then
    if [ ! -d /data/media/0/recovery ]; then
        mkdir -m 775 /data/media/0/recovery
        chown media_rw:media_rw /data/media/0/recovery
    fi
    cp /cache/recovery/fota/shortreport /data/media/0/recovery/shortreport
    chown media_rw:media_rw /data/media/0/recovery/shortreport
    chmod 664 /data/media/0/recovery/shortreport
fi
