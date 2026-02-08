#!/usr/bin/env bash
set -euo pipefail

DURATION_SEC="${1:-600}"
CORES="${2:-$(nproc)}"

echo "Stressing CPU with $CORES workers for $DURATION_SEC seconds..."
for _ in $(seq 1 "$CORES"); do
  yes > /dev/null &
done

echo "Load started. Check with: uptime"
sleep "$DURATION_SEC"

echo "Stopping stress..."
pkill yes || true
