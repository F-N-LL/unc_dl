
#!/bin/bash

# Function to print a progress bar
print_progress() {
  local progress=$1
  local total=$2
  local percent=$(( progress * 100 / total ))
  local bar_length=40
  local filled_length=$(( percent * bar_length / 100 ))
  local bar=$(printf "%0.s#" $(seq 1 $filled_length))
  local empty=$(printf "%0.s-" $(seq 1 $(( bar_length - filled_length ))))

  printf "\r[%-${bar_length}s] %d%%" "${bar}${empty}" "${percent}"
}

# Function to display bitrate options
display_bitrate_options() {
  printf "\nSelect MP3 bitrate:\n"
  printf "1) 32k (modest quality, only for big files)\n"
  printf "2) 64k\n"
  printf "3) 80k\n"
  printf "4) 96k\n"
  printf "5) 128k\n"
  printf "6) 192k\n"
}

# Function to display format options
display_format_options() {
  printf "\nSelect output format:\n"
  printf "1) mp3\n"
  printf "2) mp4\n"
}

# Prompt for the YouTube video URL
printf "\n\nPlease provide the details for downloading:\n"
read -p "YouTube URL: " URL

# Prompt for the output format (mp3 or mp4) with a selector
display_format_options
read -p "Choose an option (1-2): " FORMAT_OPTION

case $FORMAT_OPTION in
  1) FORMAT="mp3" ;;
  2) FORMAT="mp4" ;;
  *)
    printf "\nInvalid option. Using default format of mp4.\n"
    FORMAT="mp4"
    ;;
esac

# Prompt for the output file name (without extension)
read -p "Output file name (without extension): " BASE_NAME

# Set the destination directory in iCloud Drive
DESTINATION="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Podcasts/"
FILE="${DESTINATION}${BASE_NAME}.$FORMAT"

# Check the output format (only mp3 or mp4 for now)
if [[ "$FORMAT" != "mp3" && "$FORMAT" != "mp4" ]]; then
  printf "\n\nInvalid format. Only mp3 or mp4 are allowed.\n\n"
  exit 1
fi

# Bitrate selection for MP3
if [ "$FORMAT" == "mp3" ]; then
  display_bitrate_options
  read -p "Choose an option (1-6): " OPTION

  case $OPTION in
    1) BITRATE="32k" ;;
    2) BITRATE="64k" ;;
    3) BITRATE="80k" ;;
    4) BITRATE="96k" ;;
    5) BITRATE="128k" ;;
    6) BITRATE="192k" ;;
    *)
      printf "\n\nInvalid option. Using default bitrate of 128k.\n\n"
      BITRATE="128k"
      ;;
  esac
fi

# Download the YouTube file
printf "\n\nDownloading YouTube video from $URL in $FORMAT format...\n"
if [ "$FORMAT" == "mp3" ]; then
  yt-dlp -x --audio-format mp3 --audio-quality "$BITRATE" -o "$FILE" "$URL"
elif [ "$FORMAT" == "mp4" ]; then
  yt-dlp -x --audio-format mp4 -o "$FILE" "$URL"
fi

# Monitor progress
yt-dlp -x --audio-format "$FORMAT" -o "$FILE" "$URL" 2>&1 | while IFS= read -r line; do
  if [[ $line =~ ([0-9]+)% ]]; then
    print_progress "${BASH_REMATCH[1]}" 100
  fi
done

printf "\n\nDownload complete!\n\n"

# Check if the download was successful
if [ ! -f "$FILE" ]; then
  printf "Error downloading or converting the file.\n\n"
  exit 1
fi

# Success message with emojis
printf "\n\nFile downloaded successfully at $FILE\n"
printf "🎉 The file is now available in iCloud Drive and should be accessible from your iPhone. 📱\n"
printf "✅ Script completed successfully! Have a great day! 😊\n\n"

