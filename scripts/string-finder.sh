#!/bin/sh

# Set the list of strings to search for
strings=(
    "Darwin"
    "Clear Linux OS"
    "Fedora Linux"
    "openSUSE Tumbleweed"
    "Solus"
    "OpenBSD"
    "FreeBSD"
    "Void"
    "Linux Mint"
    "Ubuntu"
    "Gentoo"
    "Arch Linux"
)

# Set the list of files to skip
skip_files=(
    "void-packages.sh"
    "yay-install.sh"
    "void-build-kernel.sh"
    "string-finder.sh"
    "youtube-dl.sh"
    "xrdp-troubleshooting.sh"
    "xrdp-status.sh"
    "xrdp-start.sh"
    "xorg-info.sh"
    "xephyr-xmonad.sh"
    "wifi-realtek-install.sh"
    "wifi-monitor-mode.sh"
    "wifi-autostart.sh"
    "usb-os.sh"
    "update-world.sh"
    "unicode.sh"
    "ui.sh"
    "ufw-setup.sh"
    "tty-install.sh"
    "tmux-example.sh"
    "timezone.sh"
    "thumbnail.sh"
    "testdisk-install.sh"
    "task-spooler-install.sh"
    "suse-build-kernel.sh"
    "statics.sh"
    "standard-notes-install.sh"
    "stack-package-list.sh"
)

# Loop through each file in the current directory
for file in *
do
    # Check if the file is a regular file and not a directory
    if [ -f "$file" ]; then
        if printf '%s\n' "${skip_files[@]}" | grep -qF "$file"; then
            continue
        fi
        printf '%s\n' "Checking $file for required strings..."
        # Loop through each string and check if it is present or missing from the file
        present_strings=""
        missing_strings=()
        for s in "${strings[@]}"
        do
            if grep -qF "$s" "$file"; then
                # Check if the string "if" is on the same line as the string value
                if grep -qF "if" <<< "$s"; then
                    present_strings="$present_strings \"$s (with if)\""
                else
                    present_strings="$present_strings \"$s\""
                fi
            else
                missing_strings+=("$s")
            fi
        done
        # Print a message indicating which strings are present and missing from the file
        if [ ${#missing_strings[@]} -gt 0 ]; then
            printf '%s\n' "$file: is missing the following string(s):"
            for m in "${missing_strings[@]}"
            do
                printf 'elif [ "$OS" = "%s" ]; then\n  echo "%s"\n' "$m" "$m"
            done
        elif [ -n "$present_strings" ]; then
            #printf '%s contains the following string(s):%s\n' "$file" "$present_strings"
            printf '%s: contains all strings.\n' "$file"
        fi
    fi
done

exit 0

# vim: set ft=sh:
