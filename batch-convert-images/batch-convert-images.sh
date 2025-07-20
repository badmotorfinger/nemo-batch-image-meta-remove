#!/bin/bash

TEXTDOMAIN="batch-image-meta-remove@badmotorfinger"
TEXTDOMAINDIR="${HOME}/.local/share/locale"

# Metadata removal

_PROGRESS_TITLE=$"Removing Image Metadata"
_PROGRESS_TEXT=$"Processing..."
_NOT_A_JPEG=$"is not a JPEG file and will be skipped"
_SUCCESS=$"Metadata removed successfully"

PROGRESS_TITLE="$(/usr/bin/gettext "$_PROGRESS_TITLE")"
PROGRESS_TEXT="$(/usr/bin/gettext "$_PROGRESS_TEXT")"
NOT_A_JPEG="$(/usr/bin/gettext "$_NOT_A_JPEG")"
SUCCESS="$(/usr/bin/gettext "$_SUCCESS")"

remove_metadata() {
  local FILE="$1"
  
  # Check if file is JPEG/JPG
  if [[ "${FILE,,}" =~ \.(jpg|jpeg)$ ]]; then
    # Remove all metadata using jhead
    /usr/bin/jhead -purejpg "$FILE"
    return 0
  else
    return 1
  fi
}


(
  TOTAL_FILES=$#
  COUNT=0
  PROCESSED=0
  
  for FILE in "$@"; do
    if remove_metadata "$FILE"; then
      COUNT=$((COUNT + 1))
      PROCESSED=$((PROCESSED + 1))
      echo "$((COUNT * 100 / TOTAL_FILES))"
      echo "# Removing metadata from $FILE ($COUNT of $TOTAL_FILES)"
    else
      COUNT=$((COUNT + 1))
      echo "$((COUNT * 100 / TOTAL_FILES))"
      echo "# Skipping $FILE - not a JPEG file ($COUNT of $TOTAL_FILES)"
    fi
  done
  
  if [ $PROCESSED -gt 0 ]; then
    echo "100"
    echo "# $SUCCESS - $PROCESSED files processed"
  fi
) | /usr/bin/zenity --progress \
  --title="$PROGRESS_TITLE" \
  --text="$PROGRESS_TEXT" \
  --percentage=0 \
  --auto-close
