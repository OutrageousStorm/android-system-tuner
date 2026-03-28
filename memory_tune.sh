#!/bin/bash
# memory_tune.sh -- Tune Android memory management
# Usage: ./memory_tune.sh balanced      # balanced
#        ./memory_tune.sh battery       # minimize memory I/O
set -e

MODE="${1:-balanced}"

echo "Memory tuning mode: $MODE"

case "$MODE" in
    balanced)
        echo 60 > /proc/sys/vm/swappiness        # default
        echo 10 > /proc/sys/vm/vfs_cache_pressure
        ;;
    battery)
        echo 80 > /proc/sys/vm/swappiness        # more swap to reduce I/O
        echo 50 > /proc/sys/vm/vfs_cache_pressure
        echo 3000 > /proc/sys/vm/dirty_expire_centisecs
        ;;
    performance)
        echo 10 > /proc/sys/vm/swappiness        # minimal swap
        echo 5 > /proc/sys/vm/vfs_cache_pressure
        echo 500 > /proc/sys/vm/dirty_expire_centisecs
        ;;
esac

echo "✓ Memory tuning: $MODE"
echo "  swappiness: $(cat /proc/sys/vm/swappiness)"
echo "  cache_pressure: $(cat /proc/sys/vm/vfs_cache_pressure)"
