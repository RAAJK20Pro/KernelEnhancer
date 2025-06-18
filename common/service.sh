#!/system/bin/sh
# =============================================
# Majestic Kernel Tweaks v1
# Author: (@RAAJK20Pro)
# Telegram: https://t.me/Raphaelgamers
 
sleep 30s
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 5
done

chmod +x /data/adb/modules/Raphael/common/Majestic.sh
/data/adb/modules/Raphael/common/Majestic.sh

write() {
	
	[[ ! -f "$1" ]] && return 1
	
	
	chmod +w "$1" 2> /dev/null

	
	if ! echo "$2" > "$1" 2> /dev/null
	then
		echo "Failed: $1 → $2"
		return 1
	fi
}

sync

# =============================================
# LOGGING CONFIGURATION
# =============================================
LOG_FILE="/data/local/tmp/MajesticTweaks.log"
SDCARD_LOG="/sdcard/MajesticTweaks.log"

# Clear previous logs
: > "$LOG_FILE"
: > "$SDCARD_LOG"

# Redirect all output to both logs
exec > >(tee -a "$LOG_FILE" "$SDCARD_LOG") 2>&1

# Status Emojis
SUCCESS="✅"
FAILED="❌"
UNSUPPORTED="🚫"
WARNING="⚠️"
INFO="ℹ️"
GEAR="⚙️"

# Enhanced Logging Functions
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log_action() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1 $2"
}

write_param() {
  local path="$1"
  local value="$2"
  local description="$3"
  
  if [ ! -f "$path" ]; then
    log_action "$UNSUPPORTED" "KERNEL UNSUPPORTED: $description"
    return 2
  fi
  
  if ! echo "$value" > "$path" 2>/dev/null; then
    log_action "$FAILED" "FAILED: $description"
    return 1
  fi
  
  log_action "$SUCCESS" "APPLIED: $description"
  return 0
}

# =============================================
# INITIALIZATION
# =============================================

log "== 𝐀𝐮𝐭𝐡𝐨𝐫: (@RAAJK20Pro) =="
log "𝐃𝐞𝐯𝐢𝐜𝐞: $(getprop ro.product.model)"
log "𝐀𝐧𝐝𝐫𝐨𝐢𝐝: $(getprop ro.build.version.release)"
log "𝐊𝐞𝐫𝐧𝐞𝐥: $(uname -r)"
log "𝐒𝐭𝐚𝐫𝐭𝐢𝐧𝐠 𝐨𝐩𝐭𝐢𝐦𝐢𝐳𝐚𝐭𝐢𝐨𝐧 𝐚𝐭 $(date)"
log "Main log: $LOG_FILE"

sleep 5

# =============================================
# CORE TWEAKS (YOUR ORIGINAL PARAMETERS)
# =============================================

log "𝐊𝐄𝐑𝐍𝐄𝐋 𝐋𝐎𝐆𝐆𝐈𝐍𝐆"
write_param "/proc/sys/kernel/printk" "0 0 0 0" "Kernel printk level"
write_param "/proc/sys/kernel/panic" "0" "Kernel panic timeout"
write_param "/proc/sys/kernel/sysrq" "0" "Magic SysRq keys"
write_param "/proc/sys/kernel/shmmax" "4294967296" "Max shared memory"
write_param "/proc/sys/kernel/shmall" "4194304" "Shared memory pages"

log "𝐕𝐈𝐑𝐓𝐔𝐀𝐋 𝐌𝐄𝐌𝐎𝐑𝐘"
write_param "/proc/sys/vm/swappiness" "100" "VM swappiness"
write_param "/proc/sys/vm/dirty_ratio" "10" "Dirty ratio"
write_param "/proc/sys/vm/dirty_expire_centisecs" "6000" "Dirty expire"
write_param "/proc/sys/vm/dirty_writeback_centisecs" "1000" "Dirty writeback"
write_param "/proc/sys/vm/page-cluster" "2" "Page cluster"
write_param "/proc/sys/vm/dirty_background_ratio" "5" "Dirty background ratio"
write_param "/proc/sys/vm/min_free_kbytes" "6144" "Min free kbytes"
write_param "/proc/sys/vm/vfs_cache_pressure" "60" "VFS cache pressure"
write_param "/proc/sys/vm/watermark_scale_factor" "256" "Watermark scale"

log "𝐂𝐏𝐔 𝐇𝐎𝐓𝐏𝐋𝐔𝐆"
for cpu in /sys/devices/system/cpu/cpu[0-7]; do
  [ -d "$cpu" ] && write_param "$cpu/online" "1" "CPU ${cpu##*cpu} activation"
done

# =============================================
# SCHEDUTIL TWEAKS FOR BIG CORE AND PRIME CORE (4-7)
# =============================================

log "𝐒𝐂𝐇𝐄𝐃𝐔𝐓𝐈𝐋 𝐓𝐖𝐄𝐀𝐊𝐒 𝐅𝐎𝐑 𝐁𝐈𝐆 𝐂𝐎𝐑𝐄 𝐀𝐍𝐃 𝐏𝐑𝐈𝐌𝐄 𝐂𝐎𝐑𝐄"
for core in 4 5 6 7; do
  CPU_DIR="/sys/devices/system/cpu/cpu$core/cpufreq"
  
  # Verify schedutil governor
  if [ -f "$CPU_DIR/scaling_governor" ] && [ "$(cat $CPU_DIR/scaling_governor)" = "schedutil" ]; then
    
    # Hispeed Load (when to jump to hispeed_freq)
    write_param "$CPU_DIR/schedutil/hispeed_load" "80" "Core $core hispeed_load"
    
    # Hispeed Frequency (target speed when load exceeds hispeed_load)
    write_param "$CPU_DIR/schedutil/hispeed_freq" "$(cat $CPU_DIR/scaling_max_freq)" "Core $core hispeed_freq"
    
    # Rate Limits (frequency change speed)
    write_param "$CPU_DIR/schedutil/up_rate_limit_us" "500" "Core $core up_rate_limit"
    write_param "$CPU_DIR/schedutil/down_rate_limit_us" "20000" "Core $core down_rate_limit"
    fi
done    

log "𝐒𝐂𝐇𝐄𝐃𝐔𝐋𝐄𝐑 𝐓𝐖𝐄𝐀𝐊𝐒"
write_param "/proc/sys/kernel/sched_child_runs_first" "1" "Sched child first"
write_param "/proc/sys/kernel/sched_autogroup_enabled" "0" "Sched autogroup"
write_param "/proc/sys/kernel/sched_downmigrate" "40 40" "Sched downmigrate"
write_param "/proc/sys/kernel/sched_upmigrate" "60 60" "Sched upmigrate"
write_param "/proc/sys/kernel/sched_latency_ns" "3000000" "Sched latency"
write_param "/proc/sys/kernel/sched_migration_cost_ns" "250000" "Sched migration cost"
write_param "/proc/sys/kernel/sched_tunable_scaling" "0" "Sched tunable scaling"
write_param "/proc/sys/kernel/sched_wakeup_granularity_ns" "3500000" "Sched wakeup granularity"
write_param "/proc/sys/kernel/sched_min_granularity_ns" "2500000" "Sched min granularity"

log "𝐆𝐏𝐔 𝐓𝐇𝐑𝐎𝐓𝐓𝐋𝐄 𝐃𝐈𝐒𝐀𝐁𝐋𝐄𝐃"
for gpu in /sys/class/kgsl/kgsl-3d0; do
  [ -d "$gpu" ] && {
    write_param "$gpu/thermal_pwrlevel" "0" "GPU thermal level"
    write_param "$gpu/throttling" "0" "GPU throttling"
    write_param "$gpu/force_clk_on" "1" "GPU force clock"
    write_param "$gpu/force_rail_on" "1" "GPU force rail"
    write_param "$gpu/force_no_nap" "1" "GPU no nap"
    write_param "$gpu/bus_split" "1" "GPU bus split"
  }
done

write_param "/sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost" "0" "Adrenoboost"
write_param "/sys/module/msm_performance/parameters/touchboost" "0" "Touchboost"

log "𝐈/𝐎 𝐒𝐂𝐇𝐄𝐃𝐔𝐋𝐄𝐑"
for device in $(ls /sys/block/ | grep -E 'sda|sdb|sdc|sdd|sde|sdf|mmcblk'); do
  write_param "/sys/block/${device}/queue/scheduler" "deadline" "${device} scheduler"
  write_param "/sys/block/${device}/queue/iosched/fifo_batch" "16" "${device} fifo_batch"
  write_param "/sys/block/${device}/queue/iosched/front_merges" "0" "${device} front_merges"
  write_param "/sys/block/${device}/queue/iosched/read_expire" "64" "${device} read_expire"
  write_param "/sys/block/${device}/queue/iosched/write_expire" "2000" "${device} write_expire"
  write_param "/sys/block/${device}/queue/iosched/writes_starved" "8" "${device} writes_starved"
  write_param "/sys/block/${device}/queue/iostats" "0" "${device} iostats"
  write_param "/sys/block/${device}/queue/max_sectors_kb" "512" "${device} max_sectors"
  write_param "/sys/block/${device}/queue/add_random" "0" "${device} add_random"
  write_param "/sys/block/${device}/queue/nomerges" "0" "${device} nomerges"
  write_param "/sys/block/${device}/queue/rq_affinity" "2" "${device} rq_affinity"
  write_param "/sys/block/${device}/queue/rotational" "0" "${device} rotational"
  write_param "/sys/block/${device}/queue/read_ahead_kb" "256" "${device} read_ahead"
  write_param "/sys/block/${device}/queue/nr_requests" "32" "${device} nr_requests"
done

log "𝐑𝐀𝐌/𝐙𝐑𝐀𝐌"
for ram in /sys/block/ram*/bdi; do
  [ -d "$ram" ] && write_param "$ram/read_ahead_kb" "2048" "RAM read_ahead"
done

[ -d "/sys/block/zram0" ] && {
  write_param "/sys/block/zram0/queue/read_ahead_kb" "64" "ZRAM read_ahead"
}

log "𝐄𝐍𝐓𝐑𝐎𝐏𝐘"
write_param "/proc/sys/kernel/random/write_wakeup_threshold" "4096" "Random write threshold"
write_param "/proc/sys/kernel/random/read_wakeup_threshold" "1024" "Random read threshold"
write_param "/proc/sys/kernel/random/urandom_min_reseed_secs" "128" "Urandom reseed"

log "🧹 𝐂𝐋𝐄𝐀𝐍𝐈𝐍𝐆 "
write_param "/proc/sys/vm/drop_caches" "3" "Drop caches"

# =============================================
# DEX OPTIMIZATION (YOUR ORIGINAL IMPLEMENTATION)
# =============================================

log "🧭 𝐒𝐓𝐀𝐑𝐓𝐈𝐍𝐆 𝐃𝐄𝐗 𝐎𝐏𝐓𝐈𝐌𝐈𝐙𝐀𝐓𝐈𝐎𝐍..."
log "🖐️𝐏𝐥𝐞𝐚𝐬𝐞 𝐰𝐚𝐢𝐭 𝐈𝐭 𝐰𝐢𝐥𝐥 𝐭𝐚𝐤𝐞 𝐬𝐨𝐦𝐞 𝐭𝐢𝐦𝐞𝐬"
log "𝐑𝐮𝐧𝐧𝐢𝐧𝐠 𝐃𝐞𝐱 𝐨𝐩𝐭𝐢𝐦𝐢𝐳𝐢𝐧𝐠"
cmd package compile -m speed-profile -a >> "$LOG_FILE" 2>&1 && \
  log_action "$SUCCESS" "𝗕𝗮𝘀𝗶𝗰 𝗽𝗮𝗰𝗸𝗮𝗴𝗲 𝗼𝗽𝘁𝗶𝗺𝗶𝘇𝗮𝘁𝗶𝗼𝗻" || \
  log_action "$FAILED" "𝗕𝗮𝘀𝗶𝗰 𝗽𝗮𝗰𝗸𝗮𝗴𝗲 𝗼𝗽𝘁𝗶𝗺𝗶𝘇𝗮𝘁𝗶𝗼𝗻"

for pkg in $(cmd package list packages -3 | cut -d: -f2); do
  cmd package compile -m speed -f "$pkg" >> "$LOG_FILE" 2>&1 && \
    log_action "$SUCCESS" "𝗢𝗽𝘁𝗶𝗺𝗶𝘇𝗲𝗱 $pkg" || \
    log_action "$WARNING" "𝗙𝗮𝗶𝗹𝗲𝗱 𝘁𝗼 𝗼𝗽𝘁𝗶𝗺𝗶𝘇𝗲 $pkg"
done

rm -rf /data/dalvik-cache/* >> "$LOG_FILE" 2>&1 && \
  log_action "$SUCCESS" "𝐂𝐋𝐄𝐀𝐑𝐄𝐃 𝐃𝐀𝐈𝐕𝐈𝐊 𝐂𝐀𝐂𝐇𝐄" || \
  log_action "$FAILED" "𝐅𝐚𝐢𝐥𝐞𝐝 𝐭𝐨 𝐜𝐥𝐞𝐚𝐫 𝐝𝐚𝐥𝐯𝐢𝐤 𝐜𝐚𝐜𝐡𝐞"

# =============================================
# COMPLETION
# =============================================

log "=== 𝐓𝐰𝐞𝐚𝐤𝐬 𝐂𝐨𝐦𝐩𝐥𝐞𝐭𝐞𝐝 ✔️ ==="
log "Success: $(grep -c "$SUCCESS" "$LOG_FILE")"
log "Unsupported: $(grep -c "$UNSUPPORTED" "$LOG_FILE")"
log "Warnings: $(grep -c "$WARNING" "$LOG_FILE")"
log "Failures: $(grep -c "$FAILED" "$LOG_FILE")"
log "Finished at $(date)"

exit 0
