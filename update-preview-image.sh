#!/bin/bash

# Script to create a better social preview image with proper dimensions for WhatsApp and other platforms
# This script uses ImageMagick to generate a proper preview image

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick not installed. Please install it first."
    echo "Run: sudo apt-get install imagemagick"
    exit 1
fi

# Set variables
WEBSITE_TITLE="पंडित बी.एन. शास्त्री"
WEBSITE_SUBTITLE="ज्योतिष और वास्तु विशेषज्ञ"
SOURCE_IMAGE="/home/rohan/Dev/repos/in.co.bnshastri/assets/image-pic-2.jpeg"
PREVIEW_IMAGE_PNG="/home/rohan/Dev/repos/in.co.bnshastri/assets/bnshastri-preview.png"
PREVIEW_IMAGE_WEBP="/home/rohan/Dev/repos/in.co.bnshastri/assets/bnshastri-preview.webp"

# Check if source image exists
if [ ! -f "$SOURCE_IMAGE" ]; then
    echo "Source image not found: $SOURCE_IMAGE"
    exit 1
fi

# Create the preview images (different sizes for different platforms)
echo "Creating social preview images..."

# Create standard PNG version with proper dimensions (1200x630 is optimal for most platforms)
convert -size 1200x630 xc:#ff5722 \
    "$SOURCE_IMAGE" -resize 300x300 -gravity center -geometry +0-80 -composite \
    -fill white -pointsize 60 -gravity north -annotate +0+80 "$WEBSITE_TITLE" \
    -fill white -pointsize 36 -gravity north -annotate +0+160 "$WEBSITE_SUBTITLE" \
    -fill white -pointsize 24 -gravity south -annotate +0+40 "www.bnshastri.com" \
    "$PREVIEW_IMAGE_PNG"

# Create a square version specifically for WhatsApp (1:1 aspect ratio works better)
WHATSAPP_PREVIEW_PNG="/home/rohan/Dev/repos/in.co.bnshastri/assets/bnshastri-preview-whatsapp.png"
WHATSAPP_PREVIEW_WEBP="/home/rohan/Dev/repos/in.co.bnshastri/assets/bnshastri-preview-whatsapp.webp"

convert -size 1080x1080 xc:#ff5722 \
    "$SOURCE_IMAGE" -resize 400x400 -gravity center -geometry +0-100 -composite \
    -fill white -pointsize 60 -gravity north -annotate +0+100 "$WEBSITE_TITLE" \
    -fill white -pointsize 36 -gravity north -annotate +0+180 "$WEBSITE_SUBTITLE" \
    -fill white -pointsize 24 -gravity south -annotate +0+50 "www.bnshastri.com" \
    "$WHATSAPP_PREVIEW_PNG"

# Create WebP versions
if command -v cwebp &> /dev/null; then
    cwebp -q 90 "$PREVIEW_IMAGE_PNG" -o "$PREVIEW_IMAGE_WEBP"
    cwebp -q 90 "$WHATSAPP_PREVIEW_PNG" -o "$WHATSAPP_PREVIEW_WEBP"
    echo "WebP versions created successfully."
else
    echo "Warning: cwebp not installed, can't create WebP versions."
    echo "Run: sudo apt-get install webp"
fi

# Output success message
echo "Preview images created successfully:"
echo "Standard preview (1200x630):"
echo "  PNG: $PREVIEW_IMAGE_PNG"
echo "  WebP: $PREVIEW_IMAGE_WEBP"
echo "WhatsApp preview (1080x1080):"
echo "  PNG: $WHATSAPP_PREVIEW_PNG" 
echo "  WebP: $WHATSAPP_PREVIEW_WEBP"
echo "Make sure the meta tags in index.html point to these files."
