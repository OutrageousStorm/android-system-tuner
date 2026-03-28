#!/bin/bash
# thermal_control.sh -- Adjust thermal throttling thresholds
# Usage: ./thermal_control.sh 60     # threshold at 60°C
#        ./thermal_control.sh reset  # restore defaults
set -e

TEMP="${1:-60}"

if [[ "$TEMP" == "reset" ]]; then
    echo "Resetting thermal throttling..."
    for tz in /sys/class/thermal/thermal_zone*/trip_point_*/temp; do
        # Restore to max
        echo "80000" > "$tz" 2>/dev/null || true
    done
    echo "✓ Reset"
else
    TEMP_MILLIDEG=$((TEMP * 1000))
    echo "Setting thermal threshold to: ${TEMP}°C"
    for tz in /sys/class/thermal/thermal_zone*/trip_point_0/temp; do
        echo "$TEMP_MILLIDEG" > "$tz" 2>/dev/null && echo "  $(dirname $tz): OK" || true
    done
    echo "✓ Thermal threshold: ${TEMP}°C"
fi

# Show current
echo -e "\nCurrent thermal zones:"
for tz in /sys/class/thermal/thermal_zone*/temp; do
    t=$(<$tz)
    echo "  $(dirname $tz): $(($t / 1000))°C"
done
