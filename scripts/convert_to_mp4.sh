#!/bin/sh
# First, rename files containing spaces by replacing the space with a dash.
for file in *; do
    if [ -f "$file" ] && echo "$file" | grep -q " "; then
        new_file=$(printf "%s" "$file" | tr ' ' '-')
        # Check if the new filename already exists to avoid overwriting.
        if [ -e "$new_file" ]; then
            echo "Warning: target file '$new_file' already exists. Skipping rename for '$file'."
        else
            echo "Renaming '$file' to '$new_file'..."
            mv "$file" "$new_file"
        fi
    fi
done

# Next, process each file and convert it to MP4 if necessary.
for file in *; do
    if [ -f "$file" ]; then
        # Extract the file extension and convert it to lowercase.
        ext="${file##*.}"
        lower_ext=$(printf "%s" "$ext" | tr '[:upper:]' '[:lower:]')

        # If the extension is already mp4, skip conversion.
        if [ "$lower_ext" = "mp4" ]; then
            echo "Skipping '$file' (already an MP4 file)"
            continue
        fi

        # Remove the extension from the original file name.
        base="${file%.*}"
        out="${base}.mp4"

        echo "Converting '$file' to '$out'..."
        ffmpeg -i "$file" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k "$out"
    fi
done
