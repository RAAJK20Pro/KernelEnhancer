#!/system/bin/sh
MODDIR=${0%/*}
# Telegram https://t.me/RaphaelEsports (RAAJK20Pro)

# 🧠 Enable IORAP for prefetching (Android 11+)
setprop ro.iorapd.enable true
setprop iorapd.perfetto.enable true
setprop iorapd.readahead.enable true

# VOLTE-WIFI COEXISTENCE FIXES
setprop persist.dbg.volte_avail_ovr 1
setprop persist.dbg.vt_avail_ovr 1
setprop persist.dbg.wfc_avail_ovr 1
setprop persist.radio.rat_on combine
setprop persist.radio.data_ltd_sys_ind 1
setprop persist.radio.data_con_rprt 1
setprop persist.radio.calls.on.ims 1
setprop persist.radio.volte.dan_support true

# IMS PROFILE STABILITY
setprop persist.ims.volte true
setprop persist.ims.vt true
setprop persist.ims.vt.epdg true
setprop persist.ims.disableADBLogs 1
setprop persist.ims.disableDebugLogs 1
setprop persist.ims.disableQXDMLogs 1
setprop persist.ims.disableIMSLogs 1

# NETWORK HANDOVER OPTIMIZATION
setprop ro.ril.enable.r8fd 1
setprop ro.ril.hsdpa.category 24
setprop ro.ril.hsupa.category 8
setprop ro.ril.hsxpa 5
setprop ro.ril.radio.svn 1
setprop ro.ril.enable.sdr 1
setprop ro.ril.enable.gea3 1

# CARRIER AGGREGATION (CA) TWEAKS
setprop persist.radio.enable_temp_dds true
setprop persist.radio.aosp_usr_pref_sel true
setprop persist.radio.mcfg_enabled 1
setprop persist.radio.force_on_dc true

# WIFI CALLING (VoWiFi) COMPATIBILITY
setprop persist.radio.rat_on combine
setprop persist.radio.videopause.mode 1
setprop persist.data.iwlan.enable true
setprop persist.dbg.ims_volte_enable 1

# Improve bandwidth for real-time communication
setprop net.tcp.default_init_rwnd 10000