#!/system/bin/sh
# Leave the kernel-side susfs alone; just drop the tool copies this module placed.
# (Runtime spoofs clear on the next reboot since nothing re-applies them.)
rm -f /data/adb/ksu/bin/ksu_susfs
