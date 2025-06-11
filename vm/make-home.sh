#!/bin/bash
set -euo pipefail

# --- Configuration ---
IMAGE_NAME="home.qcow2"
IMAGE_SIZE="20G"
PARTLABEL="home"
FSLABEL="home"
TMP_RAW="home.raw"

# --- Clean up previous runs ---
rm -f "$IMAGE_NAME" "$TMP_RAW"

# --- Step 1: Create raw disk image ---
echo "Creating raw disk image..."
qemu-img create -f raw "$TMP_RAW" "$IMAGE_SIZE"

# --- Step 2: Partition the image with GPT ---
echo "Partitioning with GPT..."
parted -s "$TMP_RAW" mklabel gpt
parted -s "$TMP_RAW" mkpart primary ext4 1MiB 100%
parted -s "$TMP_RAW" name 1 "$PARTLABEL"

# --- Step 3: Set up loop device and map partitions ---
echo "Setting up loop device..."
LOOPDEV=$(sudo losetup --find --show --partscan "$TMP_RAW")

# --- Step 4: Format partition with ext4 and label it ---
PART="${LOOPDEV}p1"
echo "Formatting $PART with ext4 and label '$FSLABEL'..."
sudo mkfs.ext4 -L "$FSLABEL" "$PART"

# --- Step 5: Detach loop device ---
echo "Cleaning up..."
sudo losetup -d "$LOOPDEV"

# --- Step 6: Convert to qcow2 ---
echo "Converting to QCOW2..."
qemu-img convert -f raw -O qcow2 "$TMP_RAW" "$IMAGE_NAME"
rm -f "$TMP_RAW"

echo "✅ Done! Image created: $IMAGE_NAME"
