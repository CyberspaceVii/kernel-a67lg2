#!/system/bin/sh
# Runs before zygote. Needs the matching ksu_susfs for this kernel's susfs (v2.3.0).
MODDIR=${0%/*}
BIN=/data/adb/ksu/bin/ksu_susfs

# Install our matching tool (leave KSU Next's own bin/susfs untouched).
install -m 0755 "$MODDIR/tools/ksu_susfs_arm64" "$BIN"

# Spoof /proc/bootconfig lock-state (what detectors actually read; getprop is already factory-green).
FAKE="$MODDIR/fake_bootconfig.txt"
cat /proc/bootconfig > "$FAKE"
sed -i -e 's/^androidboot.verifiedbootstate.*/androidboot.verifiedbootstate = "green"/' \
       -e 's/^androidboot.flash.locked.*/androidboot.flash.locked = "1"/' \
       -e 's/^androidboot.vbmeta.device_state.*/androidboot.vbmeta.device_state = "locked"/' "$FAKE"
"$BIN" set_cmdline_or_bootconfig "$FAKE"

# Hide the root infrastructure dir from denylisted (umounted) apps.
"$BIN" add_sus_path /data/adb

# Quiet su-domain denials so /proc/<pid> avc scraping can't spot the ksu domain.
"$BIN" enable_avc_log_spoofing 1
