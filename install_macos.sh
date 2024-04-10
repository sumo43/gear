#!/bin/bash

# Set the download URL and destination directory
download_url="https://github.com/sumo43/gear/releases/download/0.1.3mac/gearcli"
destination_dir="/usr/local/bin"
# Check if /usr/local/bin directory exists
if [ ! -d "/usr/local/bin" ]; then
    # Create the directory with sudo
    sudo mkdir -p "/usr/local/bin"
    echo "Created /usr/local/bin directory"
else
    echo "/usr/local/bin directory already exists"
fi

# Download the gearcli binary
sudo curl -fsSL "$download_url" -o "$destination_dir/gearcli"

# Make the gearcli binary executable
sudo chmod +x "$destination_dir/gearcli"

# Add the destination directory to PATH if not already present
if [[ ":$PATH:" != *":$destination_dir:"* ]]; then
    echo "export PATH=$destination_dir:\$PATH" >> ~/.bash_profile
    echo "export PATH=$destination_dir:\$PATH" >> ~/.zshrc
    echo "Added $destination_dir to PATH"
fi

echo "Installation completed successfully!"
