### KernelEnhancer v5.0 Changelog

**Author:** @RAAJK20Pro  
**Channel:** https://t.me/KernelEnhancer

## CPU
- Added CPU online enforcement for devices that hotplug cores.
- Improved Prime cluster schedutil behavior.
- Reworked Prime cluster responsiveness:
  - `up_rate_limit_us: 200 → 100`
  - `down_rate_limit_us: 100 → 1000`
  - `hispeed_load: 70 → 75`
- Better sustained gaming stability by reducing unnecessary Prime frequency drops.
- Improved governor switching reliability and verification.

## Scheduler
- Increased minimum scheduler utilization clamp:
  - `sched_util_clamp_min: 192 → 384`
- Improved task placement on performance cores.
- Reduced chances of Prime cluster remaining at very low frequencies during gaming.

## VM (Memory Management)
- Reworked RAM-based memory profiles.
- Reduced filesystem cache reclaim pressure:
  - 2GB: `60 → 40`
  - 4GB: `70 → 50`
  - 6GB: `75 → 60`
  - 8GB: `80 → 60`
  - 12GB+: `85 → 55`
- Improved cache retention and application resume speed.
- Reduced swap read latency:
  - `page-cluster: 2 → 0`
- Optimized writeback behavior:
  - `dirty_expire_centisecs: 1600 → 1250`
  - `dirty_writeback_centisecs: 800 → 850`
- Refined watermark scaling values.
- Better multitasking performance on higher RAM devices.

## STUNE
- Rebalanced Top-App tuning:
  - `schedtune.boost: 5 → 3`
  - `schedtune.prefer_idle: 1 → 0`
- Reduced background task penalty:
  - `-20 → -10`
- Removed anti-revert reapply loop.
- Lower scheduler overhead and improved thermal balance.

## Input Boost
- Completely redesigned touch boost logic.
- Added strict frequency validation.
- Improved Prime core detection.
- Prime core is now excluded from touch boosting.
- Rebalanced boost frequencies:
  - Little Cores: `75% → 50%`
  - Big Cores: `60% → 50%`
- Optimized boost duration:
  - `60ms → 50ms`
- Improved battery efficiency while maintaining responsiveness.

## zRAM
- Added writable-node verification before applying tweaks.
- Improved compatibility across different kernels.

## IO
- Retained proven MQ-Deadline and CFQ optimizations.
- Preserved:
  - `read_ahead_kb = 256`
  - `nr_requests = 64`
  - `rq_affinity = 2`
- Improved compatibility and safety checks.

## Stability & Compatibility
- Added CPU online recovery routine.
- Improved node validation and write verification.
- Better handling of read-only kernel nodes.
- Reduced risk of boot-time tuning failures.
- Improved compatibility across Snapdragon, MediaTek, and custom kernels.

---

## Expected Improvements

### Gaming
- Better Prime cluster utilization.
- More stable frame pacing.
- Reduced frequency oscillation.
- Improved long-session gaming stability.

### Battery
- Less aggressive touch boosting.
- Lower scheduler overhead.
- Improved idle efficiency.

### Multitasking
- Better app retention.
- Faster app switching.
- Reduced swap latency.

---

## Summary

### v4
- More aggressive tuning.
- Higher touch boost frequencies.
- Stronger STUNE behavior.
- Higher battery consumption.

### v5
- Smarter scheduler behavior.
- Better memory management.
- Improved Prime cluster handling.
- Lower heat generation.
- Better battery efficiency.
- More universal and stable across different devices.
