# Smart Paste Script for Wayland/Hyprland

This script provides intelligent clipboard pasting functionality that automatically handles both text and images.

## Features
- Detects clipboard content type (text or image)
- For images: saves to `/tmp` and pastes the file path instead
- For text: performs normal paste operation
- Includes error handling and logging

## Prerequisites
- Wayland session
- `wl-clipboard` tools (wl-copy, wl-paste)
- `wtype` utility

## Usage
1. Copy the script to your system
2. Make it executable: `chmod +x smart-paste.sh`
3. Run the script: `./smart-paste.sh`

## How It Works
1. Checks if clipboard has content using `wl-paste --list-types`
2. If image data is detected:
   - Extracts the image format
   - Saves the image to `/tmp/pasted_image_[timestamp].[extension]`
   - Copies the file path to clipboard
   - Simulates Ctrl+V to paste the path
3. If text data is detected:
   - Simulates Ctrl+V to paste the text directly

## Example Hyprland Binding
To use with a keybinding in Hyprland, add to your `hyprland.conf`:
```
bind = , Insert, exec, /path/to/smart-paste.sh
```

## Notes
- Images are saved in their original format when possible
- Temporary files are named with timestamps to avoid conflicts
- Script logs operations with timestamps for debugging