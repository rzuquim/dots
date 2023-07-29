#!/bin/sh

# It is needed to make nitrogen work correctly
export DISPLAY=":0"

# Defining the directory with wallpapers
BG_DIR=$HOME/.dotfiles/common/wallpapers

# Nitrogen config directory
NITROGEN_DIR=$HOME/.config/nitrogen

# Removing of the old symlink
[ -f "${NITROGEN_DIR}"/wallpaper ] && rm "${NITROGEN_DIR}"/wallpaper

# Feeding random generator with the date in seconds (UNIX time)
RANDOM=$$$(date +%s)

# Generating list of all wallpapers in the directory
BG_LIST=("${BG_DIR}"/*.jpg)

# Counting total number of files
BG_NUM=$(ls -1 "${BG_DIR}" | wc -l)

# Randomly select some number from the total number of wallpapers
SELECTED_BG=$(( $RANDOM % ${BG_NUM} ))

# Creating new symbolic link to the selected wallpaper with the name "current_bg_image.jpg" 
ln -s "${BG_LIST[$SELECTED_BG]}" "${NITROGEN_DIR}"/wallpaper

# refreshing wallpaper image
nitrogen --restore > /dev/null 2>&1 &

