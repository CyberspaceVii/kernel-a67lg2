#!/system/bin/sh
[ "$(getprop ro.product.device)" = A67L_Gen2 ] || abort "Fail! 💀 This module is for the Foxxd A67L Gen 2."
[ "$KSU" = true ] || abort "Fail! 💀 KernelSU Next is required."

ui_print "SUSFS Config CyberspaceVII"
ui_print " "
ui_print "Venting Past The Detectors:"

ok=1
[ -f "$MODPATH/tools/ksu_susfs_arm64" ] || ok=0
[ -f "$MODPATH/post-fs-data.sh" ] || ok=0

if [ "$ok" = 1 ]; then
  ui_print "Success! 😳 No one suspects a thing. (susfs is live after reboot.)"
else
  ui_print "Fail! 💀 Ejected. You were not The Impostor."
fi
