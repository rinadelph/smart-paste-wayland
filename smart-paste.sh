#!/usr/bin/env bash
# Smart Paste Script for Wayland/Hyprland
# Handles both text and images in clipboard
# Images are saved to /tmp and their paths are pasted instead

set -e

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >&2
}

# Check if wl-paste is available
if ! command -v wl-paste &> /dev/null; then
    log_message "Error: wl-paste command not found. This script requires Wayland clipboard tools."
    exit 1
fi

# Check if clipboard has content
if ! wl-paste --list-types &> /dev/null; then
    log_message "No clipboard content available"
    exit 0
fi

# Get available clipboard types
types=$(wl-paste --list-types 2>/dev/null)

# Check if clipboard contains image data
if grep -q '^image/' <<<"$types"; then
    log_message "Image data detected in clipboard"

    # Extract image format extension
    ext=$(grep -m1 '^image/' <<<"$types" | cut -d/ -f2 | cut -d';' -f1)

    # Handle common image formats
    case "$ext" in
        jpeg|jpg) ext="jpg" ;;
        png) ext="png" ;;
        gif) ext="gif" ;;
        bmp) ext="bmp" ;;
        webp) ext="webp" ;;
        tiff) ext="tiff" ;;
        *) ext="png" ;;
    esac

    # Create temporary file with timestamp
    file="/tmp/pasted_image_$(date +%s).${ext}"

    # Save image from clipboard to file
    if wl-paste > "$file" 2>/dev/null; then
        log_message "Image saved to $file"
        # Copy file path to clipboard
        echo "$file" | wl-copy
        # Paste the file path (simulate Ctrl+V)
        wtype -M ctrl -k v
    else
        log_message "Error: Failed to save image from clipboard"
        exit 1
    fi
else
    # For text content, paste directly
    log_message "Text content detected in clipboard"
    wtype -M ctrl -k v
fi

log_message "Paste operation completed successfully"