# Unc_dl

Unc_dl is a YouTube to MP3/MP4 Downloader CLI script-app. As every good Unc, we love saving time and money and having an offline storage of content to watch or listen.

A bash script that downloads YouTube videos and converts them to either MP3 or MP4 format, saving them directly to your iCloud Drive's Unc_dl folder. The script features an interactive interface with progress tracking and customizable quality settings.

Make easier to download and store your videos or mp3 files and listen to them in you iPhone later, even offline. Ideal for podcasting.
### ONLY AVAILABLE FOR macOS (for the moment)

If you donate below, I will be able to work more and more happy on this project than if you do not, consider it:

<a href="https://buymeacoffee.com/daniel_neocathedral
" style="font-size:large" target="_blank">Buy me a coffe ☕️</a>

![alt text](https://i.imgur.com/HVBibaJ.png)


### As simple as 👇👇👇
![how to unc_dl](https://s7.gifyu.com/images/SJVy4.gif)
Just like that! We have some songs ready to play on our phone.

<strong style="color: red;">PLEASE, READ THE LEGAL DISCLAIMER AT THE END BEFORE USE.</strong>

## Quick start (for developers):

```bash
# Add the repo to your local
git clone https://github.com/F-N-LL/unc_dl.git

# Make the script executable
chmod +x unc_dl.sh

# Use it, as above
./unc_dl.sh

```

## Features

- Download YouTube videos as MP3 or MP4 files
- Multiple MP3 bitrate options (32k to 192k)
- Progress bar visualization during download
- Direct save to iCloud Drive's Podcasts folder
- Interactive command-line interface
- Custom file naming
- Error handling and success confirmation
- Automatic iCloud sync for iOS device access
- Random colors on each use. Good ol' times vibes...

## Prerequisites

- macOS with iCloud Drive enabled
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) installed
- Bash shell
- [Homebrew](https://brew.sh) package manager (recommended for installation)

## Installation Guide

### 1.1 Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 1.2 Install yt-dlp
Using Homebrew:
```bash
brew install yt-dlp
```

Or using pip:
```bash
pip3 install yt-dlp
```

### 1.3 Install FFmpeg (required for audio conversion)
```bash
brew install ffmpeg
```

### 1.4 Verify Installation

Check if all components are installed correctly:
```bash
# Check yt-dlp version
yt-dlp --version

# Check FFmpeg version
ffmpeg -version

# Test script permissions
ls -l youtube-downloader.sh
```

## 1. Set up the Unc_dl machine

1. Cloning the project
```bash
# Could be cloned straight into your Home directory or script folder. Either way, make sure you run the command in the same directory as the unc_dl.sh is.

mkdir scripts
cd scripts

# Add the repo to your local
git clone https://github.com/F-N-LL/unc_dl.git
```
OPTIONAL: Straigh download the script from here: <a href="https://drive.google.com/file/d/1gal48uQtlD0OnYu57Dd3Yn6MylVp3mH0/view?usp=sharing" target="_blank">Download from Google Drive</a>

2. Either way you will need to make the scritp executable to make it work:
```bash
# Make the script executable
chmod +x unc_dl1.sh
```
## Usage

1. Run the script:
```bash
./unc_dl.sh
```

2. Follow the interactive prompts (mostly using numbers):
   - Enter the YouTube URL (paste URL)
   - Select output format (MP3 or MP4)
   - Choose a filename
   - For MP3 format, select bitrate qualit`

## MP3 Bitrate Options

- 32k: Modest quality, suitable for very large files
- 64k: Basic quality
- 80k: Improved basic quality
- 96k: Good quality
- 128k: Standard quality (default)
- 192k: High quality
`
## Output Location

Files are automatically saved to:
```
~/Library/Mobile Documents/com~apple~CloudDocs/Podcasts/
```

💡 NOTE:  If the script can't access iCloud Drive:
- Ensure iCloud Drive is enabled in System Preferences
- Check that you're signed in to your Apple ID
- Verify the Podcasts folder exists in iCloud Drive

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
MIT License

Copyright (c) [YEAR] [YOUR FULL NAME OR GITHUB USERNAME]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Support

For installation issues:
- Check that all prerequisites are installed correctly
- Verify system permissions
- Ensure iCloud Drive is properly configured
- Update all components to their latest versions


## ⚠️ Legal Disclaimer

**IMPORTANT: By using this script, you agree to the following terms:**

1. This script is intended for personal, non-commercial use only.

2. Users are solely responsible for ensuring they have the legal right to download and use any content from YouTube.

3. The script is provided "as is" without warranty of any kind. Use at your own risk.

4. Downloading copyrighted content without permission may violate:
   - YouTube's Terms of Service
   - Copyright laws
   - Intellectual property rights

5. Content creators and copyright holders retain all rights to their original work.

6. Users must:
   - Respect copyright laws
   - Obtain necessary permissions before downloading
   - Use downloaded content only for fair use purposes
   - Not redistribute or monetize downloaded content

7. This script is not affiliated with, endorsed by, or directly associated with YouTube or Google.

**By using this script, you acknowledge and agree to comply with all applicable laws and platform policies.**

## Usage Warning

- Downloading videos may be against YouTube's Terms of Service
- Always respect intellectual property rights
- Consider using official methods to access content

## Recommended Alternatives

- YouTube Premium
- Official download options provided by content creators
- Streaming services
