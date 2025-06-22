#!/system/bin/sh
# "Do more of what makes you happy."
sleep 30s
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 5
done

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
# Network Tweaks
# Author: @RAAJK20Pro
# Telegram: https://t.me/RAAJK20Pro
# =============================================

# =============================================
# LOGGING CONFIGURATION
# =============================================
LOG_FILE="/data/local/tmp/NetworkTweaks.log"
SDCARD_LOG="/sdcard/NetworkTweaks.log"

# Clear previous logs
: > "$LOG_FILE"
: > "$SDCARD_LOG"

exec 2>>"$LOG_FILE"

# Emoji Constants
SUCCESS="✅"
FAILED="❌"
UNSUPPORTED="🚫"
WARNING="⚠️"
NETWORK="🌐"
TCP="📡"
UDP="📶"
SECURITY="🔒"
MEMORY="🧠"

# Enhanced Logging
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE" >> "$SDCARD_LOG"
}

write_param() {
  local path="$1"
  local value="$2"
  local description="$3"
  local emoji="$4"
  
  if [ ! -f "$path" ]; then
    log "$UNSUPPORTED $description (KERNEL NOT SUPPORTED)"
    return 2
  fi
  
  if ! echo "$value" > "$path" 2>>"$LOG_FILE"; then
    log "$FAILED $description ( FAILED)"
    return 1
  fi
  
  log "$emoji $SUCCESS $description"
  return 0
}

# =============================================
# INITIALIZATION
# =============================================

log "=== NETWORK TWEAKS ==="
log "Device: $(getprop ro.product.model)"
log "Android: $(getprop ro.build.version.release)"
log "Kernel: $(uname -a)"
log "Started at $(date)"
log ""

# =============================================
# CORE NETWORK PARAMETERS (YOUR ORIGINAL TWEAKS)
# =============================================

log "$NETWORK === 𝗖𝗢𝗥𝗘 𝗡𝗘𝗧𝗪𝗢𝗥𝗞 𝗦𝗘𝗧𝗧𝗜𝗡𝗚𝗦 ==="
write_param "/proc/sys/net/core/netdev_max_backlog" "262144" "Packet backlog limit" "$NETWORK"
write_param "/proc/sys/net/core/rmem_default" "31457280" "Default receive buffer" "$NETWORK"
write_param "/proc/sys/net/core/rmem_max" "67108864" "Max receive buffer" "$NETWORK"
write_param "/proc/sys/net/core/wmem_default" "31457280" "Default send buffer" "$NETWORK"
write_param "/proc/sys/net/core/wmem_max" "67108864" "Max send buffer" "$NETWORK"
write_param "/proc/sys/net/core/somaxconn" "65535" "Max connection backlog" "$NETWORK"
write_param "/proc/sys/net/core/optmem_max" "25165824" "Socket option memory" "$NETWORK"
log ""

# =============================================
# IPV4 NEIGHBOR SETTINGS (YOUR ORIGINAL TWEAKS)
# =============================================

log "$NETWORK === 𝗔𝗥𝗣 𝗖𝗔𝗖𝗛𝗘 𝗢𝗣𝗧𝗜𝗠𝗜𝗭𝗔𝗧𝗜𝗢𝗡 ==="
write_param "/proc/sys/net/ipv4/neigh/default/gc_thresh1" "4096" "ARP garbage threshold 1" "$NETWORK"
write_param "/proc/sys/net/ipv4/neigh/default/gc_thresh2" "8192" "ARP garbage threshold 2" "$NETWORK"
write_param "/proc/sys/net/ipv4/neigh/default/gc_thresh3" "16384" "ARP garbage threshold 3" "$NETWORK"
write_param "/proc/sys/net/ipv4/neigh/default/gc_interval" "5" "ARP garbage interval" "$NETWORK"
write_param "/proc/sys/net/ipv4/neigh/default/gc_stale_time" "120" "ARP stale time" "$NETWORK"
log ""

# =============================================
# CONNECTION TRACKING (YOUR ORIGINAL TWEAKS)
# =============================================

log "$MEMORY === 𝗖𝗢𝗡𝗡𝗘𝗖𝗧𝗜𝗢𝗡 𝗧𝗥𝗔𝗖𝗞𝗜𝗡𝗚 ==="
write_param "/proc/sys/net/netfilter/nf_conntrack_max" "10000000" "Max connection tracking" "$MEMORY"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_loose" "0" "Disable loose TCP tracking" "$MEMORY"

# TCP Timeouts
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_established" "1800" "TCP established timeout" "$TCP"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_close" "10" "TCP close timeout" "$TCP"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_close_wait" "10" "TCP close_wait timeout" "$TCP"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_fin_wait" "20" "TCP fin_wait timeout" "$TCP"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_last_ack" "20" "TCP last_ack timeout" "$TCP"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_syn_recv" "20" "TCP syn_recv timeout" "$TCP"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_syn_sent" "20" "TCP syn_sent timeout" "$TCP"
write_param "/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_time_wait" "10" "TCP time_wait timeout" "$TCP"
log ""

# =============================================
# TCP OPTIMIZATION (YOUR ORIGINAL TWEAKS)
# =============================================

log "$TCP === 𝗧𝗖𝗣 𝗣𝗥𝗢𝗧𝗢𝗖𝗢𝗟 𝗧𝗪𝗘𝗔𝗞𝗦 ==="
write_param "/proc/sys/net/ipv4/tcp_slow_start_after_idle" "0" "Disable slow start after idle" "$TCP"
write_param "/proc/sys/net/ipv4/ip_local_port_range" "1024 65000" "Local port range" "$TCP"
write_param "/proc/sys/net/ipv4/route/max_size" "8048576" "Routing table size" "$TCP"

# TCP Algorithms
write_param "/proc/sys/net/ipv4/tcp_congestion_control" "westwood" "TCP congestion algorithm" "$TCP"

# TCP Memory Management
write_param "/proc/sys/net/ipv4/tcp_mem" "65536 131072 262144" "TCP memory pressure" "$MEMORY"
write_param "/proc/sys/net/ipv4/udp_mem" "65536 131072 262144" "UDP memory pressure" "$MEMORY"
write_param "/proc/sys/net/ipv4/tcp_rmem" "4096 87380 33554432" "TCP read buffers" "$MEMORY"
write_param "/proc/sys/net/ipv4/tcp_wmem" "4096 87380 33554432" "TCP write buffers" "$MEMORY"
write_param "/proc/sys/net/ipv4/udp_rmem_min" "16384" "Min UDP read buffer" "$UDP"
write_param "/proc/sys/net/ipv4/udp_wmem_min" "16384" "Min UDP write buffer" "$UDP"

# TCP Connection Management
write_param "/proc/sys/net/ipv4/tcp_max_tw_buckets" "1440000" "Max TIME_WAIT sockets" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_tw_recycle" "0" "Disable TIME_WAIT recycle" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_tw_reuse" "1" "Enable TIME_WAIT reuse" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_max_orphans" "400000" "Max orphan sockets" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_window_scaling" "1" "Enable window scaling" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_rfc1337" "1" "Enable RFC1337 protection" "$SECURITY"
write_param "/proc/sys/net/ipv4/tcp_syncookies" "1" "Enable SYN cookies" "$SECURITY"
write_param "/proc/sys/net/ipv4/tcp_synack_retries" "1" "SYN-ACK retries" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_syn_retries" "2" "SYN retries" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_max_syn_backlog" "16384" "SYN backlog queue" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_low_latency" "1" "Enable low latency mode" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_fastopen" "3" "TCP Fast Open level" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_timestamps" "1" "Enable TCP timestamps" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_sack" "1" "Enable selective ACK" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_ecn" "2" "Explicit Congestion Notification" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_fin_timeout" "10" "FIN timeout" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_keepalive_time" "600" "Keepalive time" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_keepalive_intvl" "60" "Keepalive interval" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_keepalive_probes" "10" "Keepalive probes" "$TCP"
write_param "/proc/sys/net/ipv4/tcp_no_metrics_save" "1" "Disable metrics saving" "$TCP"
log ""

# =============================================
# NETWORK SECURITY
# =============================================

log "$SECURITY === 𝗡𝗘𝗧𝗪𝗢𝗥𝗞 𝗛𝗔𝗥𝗗𝗘𝗡𝗜𝗡𝗚 ==="
write_param "/proc/sys/net/ipv4/ip_forward" "0" "Disable IP forwarding" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/accept_redirects" "0" "Disable ICMP redirects" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/send_redirects" "0" "Disable send redirects" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/rp_filter" "1" "Enable reverse path filtering" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/mc_forwarding" "0" "Disable multicast forwarding" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/log_martians" "1" "Log martian packets" "$SECURITY"
write_param "/proc/sys/kernel/randomize_va_space" "2" "Full ASLR protection" "$SECURITY"
write_param "/proc/sys/kernel/exec-shield" "1" "Enable exec-shield" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/proxy_arp" "0" "Disable proxy ARP" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/secure_redirects" "1" "Secure redirects only" "$SECURITY"
write_param "/proc/sys/net/ipv4/conf/all/bootp_relay" "0" "Disable bootp relay" "$SECURITY"
write_param "/proc/sys/net/ipv4/route/flush" "1" "Flush routing cache" "$NETWORK"
log ""

# =============================================
# FINALIZATION
# =============================================

log "=== OPTIMIZATION SUMMARY ==="
log "Successful tweaks: $(grep -c "$SUCCESS" "$LOG_FILE")"
log "Unsupported features: $(grep -c "$UNSUPPORTED" "$LOG_FILE")"
log "Failed attempts: $(grep -c "$FAILED" "$LOG_FILE")"
log ""
log "=== 𝐓𝐂𝐏 𝐓𝐖𝐄𝐀𝐊𝐒 𝐂𝐎𝐌𝐏𝐋𝐄𝐓𝐄𝐃 ✔️ ==="
log "== 𝐀𝐮𝐭𝐡𝐨𝐫: (@RAAJK20Pro) =="
log "Finished at $(date)"

exit 0
