# Nemo Batch Image Metadata Remover

A Nemo file manager action extension that removes metadata from JPEG images directly from the context menu.

## Features

- **Batch metadata removal** from JPEG/JPG files
- **Progress tracking** with visual progress bar
- **Multi-language support** with internationalization
- **File validation** to skip non-JPEG files
- **Safe processing** that preserves image quality

## Supported Formats

### Input Formats
- JPEG files (.jpg, .jpeg)

## Installation

1. Copy the `batch-convert-images@badmotorfinger.nemo_action` file to:
   - `~/.local/share/nemo/actions/` (user-specific)
   - `/usr/share/nemo/actions/` (system-wide)

2. Copy the `batch-convert-images/` directory to the same location

3. Enjoy

## Dependencies

The following packages must be installed:
- `zenity` - GUI dialogs
- `jhead` - JPEG metadata removal tool
- `file` - File type detection

Install on Ubuntu/Debian:
```bash
sudo apt install zenity jhead file
```

## Usage

1. Select one or more JPEG files in Nemo
2. Right-click and choose "Remove JPEG metadata"
3. The tool will automatically process all selected JPEG files
4. Progress is shown with a visual progress bar

### What Gets Removed

The tool removes all EXIF metadata from JPEG files, including:
- Camera settings (ISO, aperture, shutter speed)
- GPS location data
- Date/time information
- Camera make and model
- Thumbnail images
- All other embedded metadata

## File Structure

```
batch-convert-images@badmotorfinger.nemo_action  # Nemo action definition
batch-convert-images/
├── batch-convert-images.sh                     # Main metadata removal script
├── icon.png                                    # Action icon
└── metadata.json                              # Extension metadata
```

## Localization

The extension supports multiple languages including:
- English, Spanish, French, Italian, German
- Portuguese, Dutch, Finnish, Hungarian
- Czech, Ukrainian, Catalan, Basque

## Technical Details

- Uses `jhead -purejpg` command to safely remove all metadata
- Preserves original image quality during processing
- Processes files in-place (overwrites originals)
- Provides detailed progress feedback

## Author

Created by **badmotorfinger**

## Version

1.0.0
