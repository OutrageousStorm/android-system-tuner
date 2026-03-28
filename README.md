# ⚙️ Android System Tuner

Direct sysfs tweaks for Android performance, power, and thermal tuning.

## Tools

- `cpu_governor.sh` — Switch CPU governors (schedutil, interactive, powersave)
- `io_scheduler.sh` — Change block device I/O scheduler
- `cpu_freq_lock.sh` — Lock CPU frequency for benchmarking
- `thermal_control.sh` — Thermal throttling limits
- `memory_tune.sh` — Memory swappiness, page cache tuning

## Usage (requires root or Magisk)
```bash
./cpu_governor.sh interactive       # set interactive
./io_scheduler.sh deadline          # set deadline I/O
./cpu_freq_lock.sh 1800000          # lock to 1.8 GHz
./thermal_control.sh 60             # thermal threshold at 60°C
```
