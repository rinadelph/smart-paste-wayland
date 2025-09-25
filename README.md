# Clip2Path - Smart Clipboard Handler for Wayland/Hyprland

This script provides intelligent clipboard handling functionality that automatically manages both text and images in Wayland environments.

## Features
- Detects clipboard content type (text or image)
- For images: saves to `/tmp` and converts clipboard content to file path
- For text: passes through unchanged
- Works seamlessly with Hyprland keybindings

## Prerequisites
- Wayland session
- `wl-clipboard` tools (wl-copy, wl-paste)

## Usage
1. Copy the script to your system
2. Make it executable: `chmod +x clip2path`
3. The script is typically used in Hyprland keybindings, not run directly

## How It Works
1. Checks clipboard content types using `wl-paste --list-types`
2. If image data is detected:
   - Extracts the image format extension
   - Saves the image to `/tmp/clip_[timestamp].[extension]`
   - Outputs the file path to stdout
3. If text data is detected:
   - Outputs the text content unchanged

## Example Hyprland Binding
The script is already bound to your Insert key in Hyprland:
```
bind = , Insert, exec, ~/.local/bin/clip2path | wl-copy && wtype -M ctrl -k v
```

This binding:
1. Runs clip2path which processes clipboard content
2. Pipes the output (file path for images, text for regular content) to wl-copy
3. Uses wtype to simulate Ctrl+V to paste the content

## Notes
- Images are automatically saved with appropriate extensions
- Temporary image files use Unix timestamps to prevent naming conflicts
- The script is optimized for use with keybindings rather than direct execution