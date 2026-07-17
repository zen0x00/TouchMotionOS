#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ISO="${1:-$REPO_ROOT/result/iso/$(ls "$REPO_ROOT/result/iso/" | grep '\.iso$' | head -1)}"

if [[ ! -f "$ISO" ]]; then
  echo "No ISO found. Build first: nix build .#nixosConfigurations.live.config.system.build.isoImage" >&2
  exit 1
fi

echo "Launching: $ISO"

exec nix-shell -p qemu --run "
qemu-system-x86_64 \
  -m 2048 \
  -smp 2 \
  -cdrom '$ISO' \
  -boot d \
  -enable-kvm \
  -vga virtio \
  -display gtk,zoom-to-fit=on \
  -device usb-ehci \
  -device usb-tablet \
  -serial mon:stdio
"
