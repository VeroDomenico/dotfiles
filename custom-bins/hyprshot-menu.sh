#!/usr/bin/env bash
set -euo pipefail

# Config
SCREENSHOT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
FREEZE="${FREEZE:-true}"
LAUNCHER="${LAUNCHER:-auto}" # auto | rofi | wofi | dmenu

mkdir -p "$SCREENSHOT_DIR"
ts() { date +"%Y-%m-%d_%H-%M-%S"; }

pick() {
  local items
  items=$(printf "%s\n" \
    "Area → Clipboard" \
    "Area → File" \
    "Window → Clipboard" \
    "Window → File" \
    "Monitor → Clipboard" \
    "Monitor → File")
  case "$LAUNCHER" in
  rofi) printf "%s\n" "$items" | rofi -dmenu -i -p "Hyprshot" ;;
  wofi) printf "%s\n" "$items" | wofi --dmenu -p "Hyprshot" ;;
  dmenu) printf "%s\n" "$items" | dmenu -i -p "Hyprshot" ;;
  auto)
    if command -v rofi >/dev/null 2>&1; then
      printf "%s\n" "$items" | rofi -dmenu -i -p "Hyprshot"
    elif command -v wofi >/dev/null 2>&1; then
      printf "%s\n" "$items" | wofi --dmenu -p "Hyprshot"
    else
      printf "%s\n" "$items" | dmenu -i -p "Hyprshot"
    fi
    ;;
  *) printf "%s\n" "$items" | rofi -dmenu -i -p "Hyprshot" ;;
  esac
}

# Base hyprshot command
cmd=(hyprshot)
$FREEZE && cmd+=(--freeze)

choice="$(pick)" || exit 1

case "$choice" in
"Area → Clipboard")
  "${cmd[@]}" -m region --clipboard-only
  ;;
"Area → File")
  file="area_$(ts).png"
  "${cmd[@]}" -m region -o "$SCREENSHOT_DIR" -f "$file"
  ;;
"Window → Clipboard")
  "${cmd[@]}" -m window --clipboard-only
  ;;
"Window → File")
  file="$SCREENSHOT_DIR/window_$(ts).png"
  "${cmd[@]}" -m window -o "$SCREENSHOT_DIR" -f "$file"
  ;;
"Monitor → Clipboard")
  "${cmd[@]}" -m window --clipboard-only
  ;;
"Monitor → File")
  file="$SCREENSHOT_DIR/monitor_$(ts).png"
  "${cmd[@]}" -m monitor -o "$SCREENSHOT_DIR" -f "$file"
  ;;
*) exit 1 ;;
esac
