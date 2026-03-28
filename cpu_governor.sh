#!/bin/bash
# cpu_governor.sh -- Switch Android CPU governor
# Usage: ./cpu_governor.sh <governor>
# Governors: schedutil, interactive, ondemand, performance, powersave, conservative
set -e

GOV="${1:-schedutil}"
VALID="schedutil interactive ondemand performance powersave conservative"

[[ $VALID == *"$GOV"* ]] || { echo "Invalid governor: $GOV"; exit 1; }

echo "Setting CPU governor to: $GOV"

for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo "$GOV" > "$cpu" 2>/dev/null || echo "  (skipped: $(dirname $cpu))"
done

for cpu in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
    echo "performance" > "$cpu" 2>/dev/null || true
done

echo "✓ Governor: $GOV"
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
