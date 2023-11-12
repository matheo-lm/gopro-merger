# Video Timestamp Overlay and Merge Script

This script processes a series of MP4 videos by adding a timestamp overlay reflecting each video's recording time and merges them into a single output file.

## Features

- Extracts recording timestamp metadata from each video file.
- Adjusts the timestamp to Eastern Standard Time.
- Adds a timestamp overlay to each video.
- Merges all processed videos into one file.

## Requirements

- FFmpeg
- ffprobe
- Bash environment

## Usage

1. Place the script in a directory you wish to execute it from.
2. Ensure that FFmpeg and ffprobe are installed and accessible in your PATH.
3. Run the script from the terminal:

   ```bash
   bash video_processing.sh
   ```
