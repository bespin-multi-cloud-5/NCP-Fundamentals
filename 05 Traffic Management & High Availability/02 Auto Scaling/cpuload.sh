#!/bin/bash
set -uo pipefail

WORKERS="${1:-$(nproc)}"
DURATION="${2:-600}"
pids=()
trap 'kill "${pids[@]}" 2>/dev/null; wait 2>/dev/null' EXIT INT TERM

echo "load with ${WORKERS} worker(s) for ${DURATION}s (Total Cores: $(nproc))"

for ((i=0; i<WORKERS; i++)); do
  sha1sum /dev/zero &
  pids+=("$!")
done

sleep "$DURATION"
