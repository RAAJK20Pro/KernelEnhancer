# MajesticTweaks 2.5 - @RAAJK20Pro

## v2.5 – 2025-06-19

# Changelog

#                              *Build.prop Tweaks*
### General System Performance
- Enabled faster reboot with `ro.config.hw_quickpoweron=true`
- Disabled aggressive power saving to reduce touch/input lag
- Disabled JNI and CPU Vsync checks for lower latency
- Enabled high-performance power profile and disabled autoscaling

### I/O & Cache Tuning
- Optimized app cache with configurable clean interval and cache size
- Improved SQLite performance using WAL journal and syncmode
- Reduced wake lock timeout and background service wake lock handling

### Memory & Multitasking Enhancements
- Increased background service and app limits (up to 192 processes)
- Applied custom LMK and DHA tuning for better RAM management
- Disabled Smart Process Management (SPM) for uninterrupted multitasking
- Tuned Zygote and Dalvik heap properties for smoother app launches

### Touch, UI & Framebuffer Optimizations
- Increased fling velocity and max UI event rate for smoother scrolling
- Triple buffering enabled for GPU-heavy rendering
- Optimized SurfaceFlinger and framebuffer settings
- Enabled faster screen refresh with improved dirty region rendering
- Boosted scheduler parameters for UI responsiveness

### Graphics & GPU
- Forced GPU rendering and triple buffering
- Disabled dithering and set high buffer sizes for HWUI
- Enabled SF latch-unlimited for reduced rendering jitter
- Tweaked EGL and HWUI for maximum GPU acceleration

### Boot & Animation
- Increased boot animation FPS for faster startup visual flow

### Networking & Connectivity
- Increased default TCP window size for faster data throughput
- Enabled support for real-time communication (init_rwnd tweak)

### Security & Stability
- Enabled ASLR and Exec Shield for memory safety
- Disabled unused and crash-prone background sync features
- Set `ro.keep_going=true` to suppress service crash loops

### Input & Latency
- Reduced touch slop for more responsive input
- Set scheduler boost and migration cost for real-time interaction

### Miscellaneous
- Enabled iorap prefetching and app relaunch acceleration
- Optimized PNP-related performance for top-activity speed
- Configured scroll boost and UI responsiveness flags

---

## Summary:
This version significantly enhances:
- **Touch responsiveness**
- **System multitasking**
- **RAM optimization**
- **GPU/UI performance**
- **Startup and input latency**

**************************************************************************************************************
                                      *Kernel Tweaks*
### System Behavior & Kernel Tweaks
- Disabled adaptive power saver and enabled fixed performance mode
- Disabled kernel panic timeout, magic SysRq keys, and ram dumps
- Lowered console log level for reduced logging overhead
- Increased max shared memory, message queues, and file handles
- Set high swappiness and optimized dirty writeback parameters

### CPU & Governor Optimizations
- Applied `schedutil` governor to all cores with tuned `up/down_rate_limit_us`
- Set custom `hispeed_freq` values for little, big, and prime cores
- Configured input boost frequencies for better touch response
- Tuned scheduler granularity and migration for low-latency task handling
- Disabled `sched_autogroup` and forced performance for certain libraries (e.g. PUBG, Unity)
- Set util clamp min/max and real-time scheduler period/runtime values

### GPU & Thermal Management
- Disabled AdrenoBoost, touch boost, GPU thermal throttling, and bus sleeping
- Locked GPU min frequency and enabled constant rail/clock control
- Set `simple_ondemand` GPU governor for responsive scaling

### Memory & Cache Tweaks
- Tuned ZRAM read ahead and swappiness for app/system groups
- Optimized VFS cache pressure and enabled aggressive dirty memory flushing
- Cleaned caches and adjusted stat interval for consistent memory performance

### I/O Scheduler & Read-Ahead
- Applied `noop` I/O scheduler to all block devices
- Increased `read_ahead_kb` for storage and RAM blocks
- Disabled I/O stats, randomness, and rotational flags for SSD optimizations

### Entropy & FSYNC
- Optimized entropy thresholds for random number generation
- Disabled FSync for reduced write latency (at risk of data loss on crash)

### LPDDR4X Bandwidth Control
- Set min/max DDR and LLCC bandwidth frequencies
- Locked devfreq paths with read-only permissions for consistency

### App & Background Management
- Disabled MIUI CloudService from running in the background

### Network Stack Optimization
- Increased `netdev_max_backlog` and socket buffer limits (rmem/wmem) for high throughput
- Tuned IPv4 ARP (neighbor) garbage collection thresholds for better route stability
- Optimized TCP/UDP memory buffers and congestion controls (CUBIC, Reno, Westwood)
- Applied faster TCP connection timeouts and reduced orphaned socket overhead
- Enabled TCP Fast Open, ECN, SACK, and window scaling
- Disabled IP forwarding, redirects, and proxy ARP for improved security
- Enabled ASLR and Exec Shield for memory protection
- Flushed route table to ensure changes apply immediately

### System Stune Boosts
- Adjusted stune boost levels for top-app, foreground, and real-time categories

### Kernel & Core Tweaks
- Disabled excessive logging and panic timeout
- Increased system memory queue sizes (shmmax, msgmnb, msgmax)
- Applied aggressive writeback and caching parameters
- Tweaked entropy thresholds and virtual memory performance

### GPU Performance
- Locked Adreno GPU min frequency to 345 MHz to reduce jitter/frame drops
- Set GPU governor to `simple_ondemand` for smoother transitions
- Disabled GPU throttling and boosted thermal limits (in earlier section)

---

## Summary:
This release enhances:
- **Network throughput & latency**
- **App and UI responsiveness**
- **Gaming performance**
- **System stability**
- **Security hardening**

Tested on **Snapdragon 855**, **Android 11**, **Steroid Kernel**.


