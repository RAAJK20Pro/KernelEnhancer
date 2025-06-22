==================================
### **Android Kernel Parameter & Build.prop**
##### **🔧 Tweaks by: (RAAJK20Pro)**
#### **Update: 23 June 2025** 
==================================

### ✅ SYSTEM & PERFORMANCE
- Enabled quick boot: `ro.config.hw_quickpoweron=true`
- Set device power profile to high-performance
- Disabled JNI error checks to reduce runtime overhead
- Disabled CPU auto-scaling to avoid performance throttling
- Boosted scheduler performance via `persist.sys.sched.*`
- Aggressively optimized ART and dex2oat for speed

### 🖥️ GRAPHICS & RENDERING
- Enabled hardware acceleration and EGL tuning
- Increased buffer count and triple buffering enabled
- Disabled dirty region rendering for smoother UI
- Forced max FPS and high GPU power mode
- Tweaked SurfaceFlinger for latency reduction and stability

### 🧠 MEMORY & MULTITASKING
- Boosted background app retention (limit: 32 apps)
- ART heap optimized for better multitasking (up to 256MB)
- Increased bservice limits (background service processes)
- Disabled Samsung Smart Process Cleaner (SPCM)

### 📱 TOUCH & UI RESPONSE
- Improved touchscreen movement sensitivity
- Increased fling and scroll velocity caps
- Enabled UI FIFO scheduling and scroll boost
- Max event rate increased to reduce input latency

### 🎥 MEDIA & STREAMING
- Fully enabled Stagefright media engine
- Enhanced media playback across AAC, QCP, HTTP, recording

### ⚡ CACHING & IORAP
- Enabled IORAP predictive app launch loading
- Configured cache clean interval and size for responsiveness

### 🌐 NETWORK & COMMUNICATION
- Forced VoLTE, ViLTE, and VoWiFi availability overrides
- Disabled IMS debug logging for better stability and privacy
- Boosted HSDPA/HSUPA/GEA categories for higher throughput
- Enabled carrier aggregation, AOSP user preference support
- Optimized TCP window size for faster mobile data

### 🔋 WAKELOCK & BATTERY
- Limited wakelock timeout to 3000ms
- Disabled unnecessary wakelock modes

### 🎮 MISC. PERFORMANCE
- Forced multidisplay GPU rendering
- Kept system stable with `ro.keep_going=true`
- Enabled Qualcomm-specific performance features (`pnp.*`)
- Disabled dithering to improve GPU throughput slightly
- Maintained application preload for faster launches

==================================
*Kernel Tweaks*
==================================

# =================
### Kernel Logging & VM Tweaks
# =================
- Disabled kernel printk logging (silent logs)
- Disabled panic reboot
- Disabled Magic SysRq key combinations
- Increased max shared memory and pages

- Swappiness set to 100 (swap more aggressively)
- Lowered dirty ratios for faster disk writes
- Tuned writeback and expire timers
- Set page-cluster to 2 for smaller swap I/O chunks
- Adjusted minimum free memory
- VFS cache pressure reduced for better inode caching
- Watermark scaling set for RAM stability

# =================
### ⚙️ CPU & Scheduler Tweaks
# =================
- Forced all CPU cores online (cpu0–cpu7)
- Schedutil governor tuned (big/prime cores):
  - Increased hispeed load threshold to 80
  - Set hispeed_freq to max_freq
  - Optimized up/down rate limits
- Disabled autogrouping
- Enabled child task preference
- Improved scheduler latency, migration, and granularity

# =================
### 🎮 GPU Optimizations
# =================
- Disabled GPU throttling & thermal limits
- Forced GPU clocks and rail on
- Disabled Adrenoboost
- Disabled touchboost (for custom tuning)

# =================
### 🧮 I/O Scheduler Tuning
# =================
- Applied 'deadline' I/O scheduler to all major block devices
- Tuned fifo_batch, front_merges, write_expire, etc.
- Disabled iostats & randomness generation
- Increased read-ahead, decreased nr_requests
- Optimized for SSDs by setting `rotational=0`

# =================
### 🔃 RAM & ZRAM Optimizations
# =================
- Increased RAM read-ahead to 2048 KB
- Set ZRAM read-ahead to 64 KB

# =================
### 🔒 Entropy Tweaks
# =================
- Optimized urandom reseed rate
- Adjusted read/write entropy thresholds for faster RNG performance

# =================
### 🧹 Memory Cleanup
# =================
- Dropped page cache, dentries, and inodes (drop_caches=3)

=========================
## **Summary of Improvements**  
✅ **Better touch responsiveness**  
✅ **Improved app launch speed**  
✅ **Lower UI latency**  
✅ **Enhanced gaming performance** 
✅ **Better Battery Backup**

Tested on **Snapdragon 855**, **Android 11**, **Miui,AOSP**.
