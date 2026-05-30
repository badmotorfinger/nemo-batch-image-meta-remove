# Nemo Batch Image Metadata Remover

A Nemo file manager action that removes metadata from JPEG images directly from
the right-click context menu.

## Features

- Batch metadata removal from JPEG/JPG files
- Progress dialog with a visual progress bar (via zenity)
- Translated right-click menu entry (multiple languages)
- Skips any selected file that is not a JPEG
- Removes metadata in place using jhead

## Supported formats

- JPEG files (.jpg, .jpeg)

Other image types in the selection are skipped, because jhead only processes
JPEG files.

## Requirements

- Nemo file manager
- jhead (JPEG metadata removal)
- zenity (progress dialog)

Install the dependencies on Linux Mint, Debian or Ubuntu:

```bash
sudo apt install jhead zenity
```

## Installation

### Quick install (recommended)

From the repository directory, run:

```bash
./install.sh
```

This copies the action into `~/.local/share/nemo/actions/`, sets the absolute
path to the helper script, and restarts Nemo.

### Manual install

1. Copy the action file and the helper directory into your Nemo actions
   directory:

   ```bash
   mkdir -p ~/.local/share/nemo/actions
   cp -r batch-convert-images@badmotorfinger.nemo_action batch-convert-images \
       ~/.local/share/nemo/actions/
   chmod +x ~/.local/share/nemo/actions/batch-convert-images/batch-convert-images.sh
   ```

2. Edit the `Exec=` line in
   `~/.local/share/nemo/actions/batch-convert-images@badmotorfinger.nemo_action`
   to use the absolute path to the helper script:

   ```ini
   Exec=/home/YOUR_USER/.local/share/nemo/actions/batch-convert-images/batch-convert-images.sh %F
   ```

3. Restart Nemo so the action appears:

   ```bash
   nemo -q
   ```

## Usage

1. Select one or more JPEG files in Nemo.
2. Right-click and choose "Remove JPEG metadata".
3. A progress dialog shows each file as it is processed.

Non-JPEG files in the selection are skipped.

## What gets removed

`jhead -purejpg` strips all non-image sections from each JPEG, including:

- EXIF data (camera make and model, settings, date and time)
- GPS location data
- XMP and IPTC blocks
- Embedded thumbnails
- JPEG comment sections

The image pixels are left untouched, so quality is preserved. Files are processed
in place, so keep a backup if you need the originals.

## Localization

The right-click menu entry (its name and comment) is translated by Nemo from the
`Name[xx]` and `Comment[xx]` lines in the `.nemo_action` file. The following
languages are included, with English as the default:

- Catalan, Czech, Spanish, Basque, Finnish, French
- Hungarian, Italian, Dutch, Portuguese, Ukrainian

To add a language, add `Name[xx]=...` and `Comment[xx]=...` lines (where `xx` is
the locale code) to `batch-convert-images@badmotorfinger.nemo_action`. The
progress dialog text itself is shown in English.

## File structure

```
install.sh                                        Install script
batch-convert-images@badmotorfinger.nemo_action   Nemo action definition
batch-convert-images/
  batch-convert-images.sh                         Metadata removal script
  icon.png                                        Action icon
  metadata.json                                   Action metadata
```

## Author

Created by badmotorfinger.

## Version

1.0.0
