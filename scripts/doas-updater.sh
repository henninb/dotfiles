#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Usage: $0 <script>"
  exit 1
fi

script="$1"

# Find all lines containing "sudo" and filter out matches where sudo is part of another word
grep -n "\< *sudo\>" "$script" | while read -r line; do
  # Get the line number and command text
  line_num=$(echo "$line" | cut -d ':' -f 1)
  command=$(echo "$line" | cut -d ':' -f 2-)

  # Check if the sudo command is at the start of the command
  if echo "$command" | grep -q "^ *sudo"; then
    # Escape forward slashes in the sudo command
    escaped_command=$(echo "$command" | sed 's/\//\\\//g')
    # Replace the sudo command with doas, preserving spacing
    new_command=$(echo "$command" | sed 's/\(^ *\)\(sudo\)/\1doas/')
    # Replace the line in the file
    sed -i "${line_num}s/${escaped_command}/${new_command}/" "$script"
    # sed -i 's/^\(\s*\)sudo /\1doas /g' "$script"
  fi
done


exit 0

# vim: set ft=sh:
