#!/bin/bash

rofi_menu() {
    local title="$1"
    shift
    local -a items=()
    local -a keys=()
    local -a commands=()

    while [[ $# -gt 0 ]]; do
        keys+=("$1")
        items+=("$1) $2")
        commands+=("$3")
        shift 3
    done

    # Build keybindings
    local kb_args=()
    for i in "${!keys[@]}"; do
        kb_args+=("-kb-custom-$((i+1))" "${keys[$i]}")
    done

    printf '%s\n' "${items[@]}" | \
        rofi -dmenu -theme Monokai -no-custom -format 'i' -p "$title" "${kb_args[@]}"

    exit_code=$?
    idx=$((exit_code - 10))

    if [[ $idx -ge 0 && $idx -lt ${#commands[@]} ]]; then
        eval "${commands[$idx]}"
    fi
}

layout_menu() {
  rofi_menu "Layout" \
      "a" "layout: split (default)" "i3-msg layout toggle split" \
      "s" "layout: stack" "i3-msg layout stack" \
      "d" "layout: tabs" "i3-msg layout tabs" \
      "f" "fullscreen toggle" "i3-msg fullscreen toggle" \
      "h" "split: horizontal" "i3-msg split h" \
      "v" "split: vertical" "i3-msg split v" \
      "space" "toggle floating window" "i3-msg floating toggle" \
      "n" "display: move to left" "i3-msg move workspace to output left" \
      "m" "display: move to right" "i3-msg move workspace to output right"
}

layout_menu
