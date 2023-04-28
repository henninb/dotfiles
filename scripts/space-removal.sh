#!/bin/sh

# loop through all the shell scripts in the current directory
for file in *.sh
do
    # check if the file is readable and a regular file
    if [ -f "$file" ] && [ -r "$file" ]; then
        # remove trailing spaces using sed
        sed -i 's/[[:space:]]\+$//' "$file"
        # display the filename and the number of spaces removed
        echo "Removed trailing spaces from $file: $(grep -o '[[:space:]]\+$' "$file" | wc -l)"
    fi
done

exit 0
# vim: set ft=sh:
