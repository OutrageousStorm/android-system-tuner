#!/bin/bash
# io_scheduler.sh -- Switch Android block device I/O scheduler
# Usage: ./io_scheduler.sh <scheduler>
# Schedulers: deadline, noop, mq-deadline, bfq, kyber
set -e

SCHED="${1:-mq-deadline}"

echo "Setting I/O scheduler to: $SCHED"
for dev in /sys/block/*/queue/scheduler; do
    echo "$SCHED" > "$dev" 2>/dev/null && echo "  $(dirname $dev): $SCHED" || true
done

echo "✓ I/O scheduler set to: $SCHED"
