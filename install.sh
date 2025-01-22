#!/bin/bash

# Function to display the help menu
display_help() {
    cat << EOF
Usage: $0 [option]

Options:
  help            Display this help menu
  vim             Install Vim configuration files
  bash            Install Bash configuration files
  resources       Install resource files
  all             Install all configuration and resource files
EOF
    exit 0
}

# Ensure the script is executed with an argument
if [ "$#" -eq 0 ]; then
    display_help
    exit 1
fi

# Validate the provided argument
case "$1" in
    help)
        display_help
        ;;
    vim|bash|resources|all)
        echo "Selected option: $1"
        ;;
    *)
        display_help
        exit 1
        ;;
esac

# Define backup directory
backup_dir="$HOME/backupConfigs"

# Create the backup directory if it does not exist
if [ ! -d "$backup_dir" ]; then
    echo "Creating backupConfigs directory in the home directory..."
    mkdir -p "$backup_dir"
    echo "Directory created: $backup_dir"
else
    echo "Backup directory already exists: $backup_dir"
fi

# Function to process configuration files
deploy_files() {
    local src_dir="$1"
    local file_type="$2"

    echo "Processing $file_type configuration files..."

    for file in "$src_dir"/.*; do
        local filename=$(basename "$file")
        local target="$HOME/$filename"

        if [ -f "$target" ]; then
            local timestamp=$(date +"%Y%m%d.%H%M%S")
            local backup_file="$backup_dir/${filename}.$timestamp.bak"
            echo "Backing up existing file: $target -> $backup_file"
            mv "$target" "$backup_file"
        else
            echo "File does not exist in home directory: $filename"
        fi

        echo "Creating symbolic link: $target -> $file"
        ln -sf "$file" "$target"
    done
}

# Handle Vim argument
if [ "$1" == "vim" ] || [ "$1" == "all" ]; then
    deploy_files "$(pwd)/vim" "Vim"
fi

# Handle Bash argument
if [ "$1" == "bash" ] || [ "$1" == "all" ]; then
    deploy_files "$(pwd)/bash" "Bash"
fi

# Handle Resources argument
if [ "$1" == "resources" ] || [ "$1" == "all" ]; then
    resources_dir="$(pwd)/resources"
    target_resources="$HOME/resources"

    if [ -d "$target_resources" ]; then
        timestamp=$(date +"%Y%m%d.%H%M%S")
        backup_resources="$backup_dir/resources.$timestamp.bak"
        echo "Backing up existing resources directory: $target_resources -> $backup_resources"
        mv "$target_resources" "$backup_resources"
    else
        echo "No existing resources directory in home directory."
    fi

    echo "Creating symbolic link: $target_resources -> $resources_dir"
    ln -sf "$resources_dir" "$target_resources"
fi
