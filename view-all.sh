#!/usr/bin/env bash

# view-all.sh - Show NixOS configuration structure and file contents

CONFIG_DIR="/etc/nixos"

echo "NixOS Configuration Overview"
echo "============================"
echo

# Function to print file content with a header
print_file_content() {
    local file="$1"
    echo "--- $file ---"
    if [[ "$file" == *.nix ]]; then
        cat "$file"
    else
        echo "[Binary file - content not displayed]"
    fi
    echo
    echo
}

# Function to process directory recursively
process_directory() {
    local dir="$1"
    local prefix="$2"
    local entries=("$dir"/*)
    
    # Count entries
    local entry_count=${#entries[@]}
    local i=0
    
    for entry in "${entries[@]}"; do
        ((i++))
        local entry_name=$(basename "$entry")
        local is_last=$((i == entry_count))
        
        # Determine prefix for this entry
        local current_prefix=""
        local next_prefix=""
        
        if [[ -z "$prefix" ]]; then
            # Top level
            current_prefix="├── "
            if [[ "$is_last" -eq 1 ]]; then
                current_prefix="└── "
                next_prefix="    "
            else
                next_prefix="│   "
            fi
        else
            # Nested level
            current_prefix="${prefix}├── "
            if [[ "$is_last" -eq 1 ]]; then
                current_prefix="${prefix}└── "
                next_prefix="${prefix}    "
            else
                next_prefix="${prefix}│   "
            fi
        fi
        
        # Print entry name
        echo "${current_prefix}${entry_name}"
        
        # Process file or directory
        if [[ -f "$entry" ]]; then
            # Print file content if it's a .nix file
            if [[ "$entry" == *.nix ]]; then
                print_file_content "$entry" | sed "s/^/${next_prefix}    /"
            fi
        elif [[ -d "$entry" ]]; then
            # Recurse into directory
            process_directory "$entry" "$next_prefix"
        fi
    done
}

# Start processing from the config directory
echo "Directory Structure:"
echo "===================="
process_directory "$CONFIG_DIR" ""
