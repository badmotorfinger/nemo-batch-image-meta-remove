#!/bin/bash

# Metadata removal

remove_metadata() {
  local FILE="$1"

  # Check if file is JPEG/JPG
  if [[ "${FILE,,}" =~ \.(jpg|jpeg)$ ]]; then
    # Remove all metadata using jhead
    jhead -purejpg "$FILE"
    return 0
  else
    return 1
  fi
}

[ "$#" -eq 0 ] && exit 0

(
  TOTAL_FILES=$#
  COUNT=0
  PROCESSED=0

  for FILE in "$@"; do
    COUNT=$((COUNT + 1))
    if remove_metadata "$FILE"; then
      PROCESSED=$((PROCESSED + 1))
      echo "$((COUNT * 100 / TOTAL_FILES))"
      echo "# Removing metadata from $FILE ($COUNT of $TOTAL_FILES)"
    else
      echo "$((COUNT * 100 / TOTAL_FILES))"
      echo "# Skipping $FILE - not a JPEG file ($COUNT of $TOTAL_FILES)"
    fi
  done

  echo "100"
  echo "# Done - $PROCESSED of $TOTAL_FILES files processed"
) | zenity --progress \
  --title="Removing Image Metadata" \
  --text="Processing..." \
  --percentage=0 \
  --auto-close
