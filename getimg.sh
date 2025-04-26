#!/bin/bash

# Replace with your NASA API key
apikey="INSERT YOUR API KEY HERE"

# Initialize variables
date="$(date +%F)"
add_watermark=false

# Parse command-line options
while getopts ":d:w" opt; do
    case $opt in
    d)
        date="$OPTARG"
        ;; 
    w)
        add_watermark=true
        ;; 
    esac
done
shift $((OPTIND -1))

# Create the img directory if it doesn't exist
mkdir -p img

while true; do
    echo "trying to get the images from $date..."

    # Get the raw data from NASA API
    naturalrawdata=$(curl -sL "https://api.nasa.gov/EPIC/api/natural/date/$date?api_key=$apikey")

    # Extract the image names and dates
    imagenames=$(echo "$naturalrawdata" | jq -r '.[].image')
    dates=$(echo "$naturalrawdata" | jq -r '.[].date')

    if [ -n "$imagenames" ]; then
        echo "Found the images, downloading..."
        break
    else
        echo "$date There is no image, going back to the previous day..."
        # Back to the previous day
        date=$(date -d "$date -1 day" +%F)
    fi
done

# Create a directory to save the images by date
save_dir="img/$date"
mkdir -p "$save_dir"

# Initialize date_index
date_index=0

# Download the images
echo "$imagenames" | while read -r image; do
    image=$(echo "$image" | tr -d '\r')
    filepath="$save_dir/$image.jpg"

    if [ -f "$filepath" ]; then
        echo "already exists: $filepath, skipping."
    else
        img_url="https://epic.gsfc.nasa.gov/archive/natural/${date//-//}/jpg/$image.jpg"
        echo "downloading: $img_url"
        curl -sL "$img_url" -o "$filepath"

        # If add_watermark is true, add watermark to the image
        if $add_watermark; then
            echo "adding watermark: $filepath"
            if [[ "$OS" == "Windows_NT" ]]; then
                # Use dates list for watermark text
                magick "$filepath" -gravity southeast -pointsize 36 -fill white -annotate +10+10 "$(echo "$dates" | sed -n "$(($date_index + 1))p")" "$filepath"
            else
                # Use dates list for watermark text
                convert "$filepath" -gravity southeast -pointsize 36 -fill white -annotate +10+10 "$(echo "$dates" | sed -n "$(($date_index + 1))p")" "$filepath"
            fi
            # Add 1 to date_index
            ((date_index++))
        fi
    fi
done

echo "All images have been downloaded to $save_dir"

# Create a GIF animation
gif_output="img/$date/${date}.gif"
echo "Generating gif animation: $gif_output"

# Check if the OS is Windows or Linux
if [[ "$OS" == "Windows_NT" ]]; then
    magick -delay 20 -loop 0 "$save_dir"/*.jpg "$gif_output"
else
    convert -delay 20 -loop 0 "$save_dir"/*.jpg "$gif_output"
fi

echo "GIF animation created: $gif_output"
