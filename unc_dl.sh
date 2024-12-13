#!/bin/bash

generate_random_color() {
    # mapping colors to ads some fun 
    local colors=(
        "38;5;203" "38;5;204" "38;5;205" "38;5;206" "38;5;207" 
        "38;5;160" "38;5;161" "38;5;162" "38;5;163" "38;5;164" 
        "38;5;208" "38;5;209" "38;5;210" "38;5;211" "38;5;212" 
        "38;5;220" "38;5;221" "38;5;222" "38;5;223" "38;5;224" 
        "38;5;82"  "38;5;83"  "38;5;84"  "38;5;85"  "38;5;86"  
        "38;5;39"  "38;5;40"  "38;5;41"  "38;5;42"  "38;5;43"  
        "38;5;51"  "38;5;50"  "38;5;49"  "38;5;48"  "38;5;47"  
        "38;5;75"  "38;5;74"  "38;5;73"  "38;5;72"  "38;5;71"  
        "38;5;105" "38;5;104" "38;5;103" "38;5;102" "38;5;101" 
    )
    
    # ranodomize color
    local random_index=$((RANDOM % ${#colors[@]}))
    echo "\033[${colors[$random_index]}m"
}

BASE_COLOR=$(generate_random_color)
printf "$BASE_COLOR"

# color prexied for important parts
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# color print func
print_base() {
    printf "$BASE_COLOR%b$RESET" "$1"
}

# Function to display bitrate options
display_bitrate_options() {
    print_base "\nSelect MP3 bitrate:\n"
    print_base "1) 32k (modest quality, only for big files)\n"
    print_base "2) 64k\n"
    print_base "3) 80k\n"
    print_base "4) 96k\n"
    print_base "5) 128k\n"
    print_base "6) 192k\n"
}

# Function to display format options
display_format_options() {
    print_base "\nSelect output format:\n"
    print_base "1) mp3\n"
    print_base "2) mp4\n"
}

# Function to print a progress bar with custom message
print_progress() {
    local progress=$1
    local total=$2
    local message=$3
    local width=50
    local percent=$((progress * 100 / total))
    
    local filled=$((width * progress / total))
    local empty=$((width - filled))
    
    local fill_char="▓"
    local empty_char="░"
    
    local fill_bar=""
    local empty_bar=""
    for ((i = 0; i < filled; i++)); do
        fill_bar="${fill_bar}${fill_char}"
    done
    for ((i = 0; i < empty; i++)); do
        empty_bar="${empty_bar}${empty_char}"
    done
    
    printf "\r${YELLOW}%s ${CYAN}[${GREEN}${fill_bar}${RESET}${empty_bar}${CYAN}]${RESET} ${percent}%% " "${message}"
}
# Spinner
spinner() {
    local message=$1
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'

    printf "${YELLOW}%s${RESET} " "$message"
    for ((i=0; i<10; i++)); do
        for ((j=0; j<${#spin}; j++)); do
            printf "\r${YELLOW}%s${RESET} ${CYAN}%s${RESET}" "$message" "${spin:$j:1}"
            sleep 0.1
        done
    done
    printf "\r${YELLOW}%s${RESET} ${CYAN}✓${RESET}\n" "$message"
    
    if [[ $message == *"Extracting"* ]]; then
        (
            while true; do
                for ((j=0; j<${#spin}; j++)); do
                    printf "\r${YELLOW}Preparing conversion...${RESET} ${CYAN}%s${RESET}" "${spin:$j:1}"
                    sleep 0.1
                done
            done
        ) 2>/dev/null &
        SPINNER_PID=$!
    fi
}

# Main interface
print_base "\n\nPlease provide the details for downloading:\n"
print_base "YouTube URL: "
read URL

# Format selection
display_format_options
print_base "Choose an option (1-2): "
read FORMAT_OPTION

case $FORMAT_OPTION in
    1) FORMAT="mp3" ;;
    2) FORMAT="mp4" ;;
    *)
        print_base "\nInvalid option. Using default format of mp4.\n"
        FORMAT="mp4"
        ;;
esac

# Filename input
print_base "Output file name (without extension): "
read BASE_NAME

# Set the destination directory in iCloud Drive
DESTINATION="$HOME/Library/Mobile Documents/com~apple~CloudDocs/unc_dl/"

# Check if directory exists, if not create it
if [ ! -d "$DESTINATION" ]; then
    mkdir -p "$DESTINATION"
    if [ $? -ne 0 ]; then
        print_base "\nError: Could not create directory $DESTINATION\n"
        print_base "Please check if iCloud Drive is enabled and you have proper permissions.\n"
        exit 1
    fi
    print_base "\nCreated directory: $DESTINATION\n"
fi

FILE="${DESTINATION}${BASE_NAME}.$FORMAT"

# Check the output format
if [[ "$FORMAT" != "mp3" && "$FORMAT" != "mp4" ]]; then
    print_base "\nInvalid format. Only mp3 or mp4 are allowed.\n"
    exit 1
fi

# Bitrate selection for MP3
if [ "$FORMAT" == "mp3" ]; then
    display_bitrate_options
    print_base "Choose an option (1-6): "
    read OPTION

    case $OPTION in
        1) BITRATE="32k" ;;
        2) BITRATE="64k" ;;
        3) BITRATE="80k" ;;
        4) BITRATE="96k" ;;
        5) BITRATE="128k" ;;
        6) BITRATE="192k" ;;
        *)
            print_base "\nInvalid option. Using default bitrate of 128k.\n"
            BITRATE="128k"
            ;;
    esac
fi

# Download section
print_base "\nDownloading YouTube video from $URL in $FORMAT format...\n"

if [ "$FORMAT" == "mp3" ]; then
    current_stage=""
    
    yt-dlp --newline --progress -x --audio-format mp3 --audio-quality "$BITRATE" -o "$FILE" "$URL" 2>&1 | \
    while IFS= read -r line; do
        if [[ $line =~ "youtube" ]] || [[ $line =~ "info" ]]; then
            print_base "$line\n"
        fi
        
        if [[ $line =~ "download" ]] && [[ $line =~ ([0-9]+\.[0-9])%|([0-9]+)% ]]; then
            if [[ $current_stage != "downloading" ]]; then
                current_stage="downloading"
                print_base "\nStarting download...\n"
            fi
            percentage="${BASH_REMATCH[1]:-${BASH_REMATCH[2]}}"
            print_progress "${percentage%.*}" 100 "Downloading:"
        fi
        
        if [[ $line =~ "ExtractAudio" ]] || [[ $line =~ "Extracting audio" ]] && [[ $current_stage != "extracting" ]]; then
            current_stage="extracting"
            printf "\n"
            spinner "Extracting audio..."
        fi
        
        if [[ $line =~ "Deleting original" ]] && [[ $current_stage != "converting" ]]; then
            current_stage="converting"
            if [ ! -z "$SPINNER_PID" ]; then
                kill -SIGTERM $SPINNER_PID 2>/dev/null
                wait $SPINNER_PID 2>/dev/null
                printf "\r${YELLOW}Preparing conversion...${RESET} ${CYAN}✓${RESET}\n"
            fi
            spinner "Converting to $FORMAT..."
        fi
    done
else
    # MP4 download configuration
    current_stage=""

    yt-dlp --newline --progress -f 'best[ext=mp4]' -o "$FILE" "$URL" 2>&1 | \
    while IFS= read -r line; do
        if [[ $line =~ "youtube" ]] || [[ $line =~ "info" ]]; then
            print_base "$line\n"
        fi
        
        if [[ $line =~ "download" ]] && [[ $line =~ ([0-9]+\.[0-9])%|([0-9]+)% ]]; then
            if [[ $current_stage != "downloading" ]]; then
                current_stage="downloading"
                print_base "\nStarting download...\n"
            fi
            percentage="${BASH_REMATCH[1]:-${BASH_REMATCH[2]}}"
            print_progress "${percentage%.*}" 100 "Downloading:"
        fi
        
        if [[ $line =~ "Merging formats" ]] && [[ $current_stage != "merging" ]]; then
            current_stage="merging"
            printf "\n"
            spinner "Merging formats..."
        fi
    done
fi

# Check if download was successful
if [ ! -f "$FILE" ]; then
    print_base "\nError downloading or converting the file.\n"
    exit 1
fi

# Success messages
print_base "\nFile downloaded successfully at $FILE\n"
print_base "\n🎉 The file is now available in iCloud Drive and should be accessible from your iPhone 📱\n"
print_base "\n✅ Script completed successfully! Have a great day! 😊\n"
printf "$RESET"  # Reset color
