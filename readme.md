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
   ./video-merger.sh
   ```

4. Follow the prompts to input the directory path or use the default path.
5. Enter the desired output file name when prompted.

## Customization

You can customize the default directory path by editing the default_directory variable within the script.
Contributing

If you'd like to contribute to this script or suggest improvements, please open an issue or submit a pull request.
License

This script is open-sourced software licensed under the MIT license.

