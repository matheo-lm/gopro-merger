#!/bin/bash

# Default directory
default_directory="/Volumes/KALI/DCIM/100GOPRO/"

# Prompt user for directory or use default
read -p "Enter directory path or press enter to use default ($default_directory): " directory
directory=${directory:-$default_directory}

# Create a temporary directory for processed videos
temp_directory=$(mktemp -d)
echo "Temporary directory for processed videos: $temp_directory"

# Process each video file
count=1
for file in $(ls -tr "$directory"*.MP4); do
    echo "Processing file: $file"
    
    # Extract timestamp metadata
    timestamp=$(ffprobe -v quiet -show_entries format_tags=creation_time -of default=noprint_wrappers=1:nokey=1 "$file")
    echo "Extracted Timestamp: $timestamp"

    # Format timestamp for use in FFmpeg
    start_time=$(date -j -f "%Y-%m-%dT%H:%M:%S.000000Z" "$timestamp" +"%Y%m%d_%H%M%S")

    # Create a temporary text file with the start time
    echo "$start_time" > "$temp_directory/start_time_$count.txt"

    # Get the current timestamp in seconds since the epoch
    epoch_start_time=$(date -j -f "%Y-%m-%dT%H:%M:%S.000000Z" "$timestamp" +%s)
    adjusted_epoch_time=$(($epoch_start_time - 18000))

    # Add timestamp overlay to video with corrected epoch time
    processed_file="$temp_directory/$count.MP4"
    ffmpeg -i "$file" -vf "drawtext=fontfile=/System/Library/Fonts/Helvetica.ttc: \
          text='%{pts\:gmtime\:$adjusted_epoch_time}': \
          x=(w-tw)/2: y=10: fontcolor=white: fontsize=36: box=1: boxcolor=black@0.5:boxborderw=2" \
          -c:v libx264 -c:a copy "$processed_file"

    # Increment the counter
    count=$((count + 1))
done

# Create filelist for merging
filelist_path="$temp_directory/filelist.txt"
for file in "$temp_directory"/*.MP4; do
    echo "file '$file'" >> "$filelist_path"
done

# Merge processed videos
echo "Merging processed videos..."
read -p "Enter the output file name or press enter for 'output.mp4': " output_name
output_name=${output_name:-output.mp4}
ffmpeg -f concat -safe 0 -i "$filelist_path" -c copy "$output_name"

# Clean up
rm -r "$temp_directory"

echo "All done!!"
