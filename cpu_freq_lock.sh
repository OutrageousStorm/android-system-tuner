#!/bin/bash
# cpu_freq_lock.sh -- Lock CPU frequency for benchmarking
# Usage: ./cpu_freq_lock.sh 2000000    # lock to 2.0 GHz
#        ./cpu_freq_lock.sh unlock     # unlock
set -e

FREQ="${1:-max}"
echo "CPU Frequency: $FREQ"

if [[ "$FREQ" == "unlock" ]]; then
    echo "Unlocking frequency scaling..."
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo "schedutil" > "$cpu"
    done
    echo "✓ Unlocked"
else
    # Find closest available frequency
    avail=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies | tr ' ' '\n' | sort -rn | head -1)
    [[ "$FREQ" == "max" ]] && FREQ="$avail"
    
    echo "Locking to: $FREQ Hz"
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq; do
        echo "$FREQ" > "$cpu"
        echo "$FREQ" > "${cpu/min/max}"
    done
    echo "✓ Locked to $(($FREQ / 1000000)) MHz"
fi
