# Unc_dl

Unc_dl is a YouTube to MP3/MP4 Downloader CLI script-app. As every good Unc, we love saving time and money and having an offline storage of content to watch or listen.

A bash script that downloads YouTube videos and converts them to either MP3 or MP4 format, saving them directly to your iCloud Drive's Podcasts folder. The script features an interactive interface with progress tracking and customizable quality settings.

So usefull to download and automaticaly store your videos or mp3 files and listen to them in you iPhone later. Providing a free feature of downloading YT videos/audio. Ideal for podcast listening.

<i> <strong> LEGAL DISCLAIMER</strong>: I do not own anything downloaded through this pipeline, content and all rights belong to YouTube and Creators.</i>

## Features

- Download YouTube videos as MP3 or MP4 files
- Multiple MP3 bitrate options (32k to 192k)
- Progress bar visualization during download
- Direct save to iCloud Drive's Podcasts folder
- Interactive command-line interface
- Custom file naming
- Error handling and success confirmation
- Automatic iCloud sync for iOS device access

## Prerequisites

- macOS with iCloud Drive enabled
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) installed
- Bash shell
- [Homebrew](https://brew.sh) package manager (recommended for installation)

## Installation Guide

### 1. Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install yt-dlp
Using Homebrew:
```bash
brew install yt-dlp
```

Or using pip:
```bash
pip3 install yt-dlp
```

### 3. Install FFmpeg (required for audio conversion)
```bash
brew install ffmpeg
```

### 4. Set up the Script

1. Create a new directory for the script (optional):
```bash
mkdir ~/youtube-downloader
cd ~/youtube-downloader
```

2. Create the script file:
```bash
touch youtube-downloader.sh
```

3. Copy the script content into the file using your preferred text editor
```bash
nano youtube-downloader.sh   # or use vim, VS Code, etc.
```

4. Make the script executable:
```bash
chmod +x youtube-downloader.sh
```

### 5. Create the Podcasts directory in iCloud Drive
```bash
mkdir -p "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Podcasts"
```

### 6. Verify Installation

Check if all components are installed correctly:
```bash
# Check yt-dlp version
yt-dlp --version

# Check FFmpeg version
ffmpeg -version

# Test script permissions
ls -l youtube-downloader.sh
```

### Troubleshooting Common Installation Issues

1. If Homebrew commands fail:
```bash
# Reset Homebrew permissions
sudo chown -R $(whoami) $(brew --prefix)/*
```

2. If yt-dlp is not found:
```bash
# Add to PATH if installed with pip
export PATH="$PATH:$HOME/.local/bin"
```

3. If the script can't access iCloud Drive:
- Ensure iCloud Drive is enabled in System Preferences
- Check that you're signed in to your Apple ID
- Verify the Podcasts folder exists in iCloud Drive

## Usage

1. Run the script:
```bash
./unc_dl.sh
```

2. Follow the interactive prompts:
   - Enter the YouTube URL
   - Select output format (MP3 or MP4)
   - Choose a filename
   - For MP3 format, select bitrate quality

## MP3 Bitrate Options

- 32k: Modest quality, suitable for very large files
- 64k: Basic quality
- 80k: Improved basic quality
- 96k: Good quality
- 128k: Standard quality (default)
- 192k: High quality

## Output Location

Files are automatically saved to:
```
~/Library/Mobile Documents/com~apple~CloudDocs/Podcasts/
```

## Success Indicators

The script provides visual feedback:
- Progress bar during download
- Confirmation message upon completion
- iCloud sync status
- File location information

## Error Handling

The script includes basic error checking for:
- Invalid format selection
- Failed downloads
- Missing output files

## Notes

- Files saved to iCloud Drive will automatically sync to your iOS devices
- Download time depends on your internet connection and file size
- Higher bitrates result in better audio quality but larger file sizes
- Keep yt-dlp updated regularly: `brew upgrade yt-dlp` or `pip3 install -U yt-dlp`

## License

[Add your license information here]

## Contributing

[Add contribution guidelines if applicable]

## Support

For installation issues:
- Check that all prerequisites are installed correctly
- Verify system permissions
- Ensure iCloud Drive is properly configured
- Update all components to their latest versions

[Add additional support information or contact details]
