<!-- README.md -->
# EPIC Earth Polychromatic Imaging Camera Image Acquisition Script
[中文](README_zh.md)

## Overview
This script is used to acquire natural images of the Earth from the NASA API. It supports downloading images for a specified date and optionally adding a timestamp watermark to the downloaded images. Finally, the script combines the downloaded images into a GIF animation.

## Usage
### Basic Usage
```bash
./getimg.sh
```
This command will attempt to acquire images starting from the current date. If there are no images available for the current date, it will automatically go back to the previous day until images are found.

### Optional Parameters
- `-d <date>`: Specify the date for which to acquire images, in the format `YYYY-MM-DD`.
- `-w`: Add a watermark to the downloaded images.

### Example
```bash
./getimg.sh -d 2025-01-01 -w
```
This command will attempt to acquire images for January 1, 2025, and add a watermark to the downloaded images.

![2025-01-01 GIF Example](example/2025-01-01.gif)

## Dependencies
- `curl`: Used to fetch data from the NASA API and download images.
- `jq`: Used to parse JSON-formatted API responses.
- `ImageMagick`: Used to add watermarks to images and generate GIF animations. On Windows systems, use the `magick` command; on Linux systems, use the `convert` command.

## Configuration
Before running the script, you need to replace the `apikey` variable in the `getimg.sh` file with your own NASA API key.

```bash
# Replace with your NASA API key
apikey="YOUR_API_KEY_HERE"
```

## Output
The script will save the downloaded images to the `img/<date>` directory and generate a GIF animation file named `<date>.gif` in that directory.

## References
This project is based on the work of louis-e. The original project can be found at [nasa-api-earthpolychromaticimagingcamera](https://github.com/louis-e/nasa-api-earthpolychromaticimagingcamera)
