#!/bin/bash

# Set the download URL and destination directory
download_url="https://github.com/sumo43/gear/releases/download/0.1.3linux/gearcli"
destination_dir="/usr/local/bin"

# Check if sudo is available
if command -v sudo >/dev/null 2>&1; then
    sudo_cmd="sudo"
else
    sudo_cmd=""
    echo "sudo not found. Attempting installation without sudo."
fi

# Check if the destination directory exists
if [ ! -d "$destination_dir" ]; then
    # Create the directory with sudo if available, otherwise without sudo
    ${sudo_cmd} mkdir -p "$destination_dir"
    echo "Created $destination_dir directory"
else
    echo "$destination_dir directory already exists"
fi

# Download the gearcli binary with sudo if available, otherwise without sudo
${sudo_cmd} curl -fsSL "$download_url" -o "$destination_dir/gearcli"

# Make the gearcli binary executable with sudo if available, otherwise without sudo
${sudo_cmd} chmod +x "$destination_dir/gearcli"

# Add the destination directory to PATH if not already present
profile_files=("$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.zshrc" "$HOME/.profile")

for file in "${profile_files[@]}"; do
    if [ -f "$file" ]; then
        if ! grep -q "export PATH=$destination_dir:\$PATH" "$file"; then
            echo "export PATH=$destination_dir:\$PATH" >> "$file"
            echo "Added $destination_dir to PATH in $file"
        fi
    fi
done

echo "Installation completed successfully!"
