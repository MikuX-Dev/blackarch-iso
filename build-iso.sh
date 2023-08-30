#!/bin/bash

# Check if the script is being run as root
if [ "$(id -u)" != 0 ]; then
  echo "This script must be run as root. Exiting."
  exit 1
fi

# Function to perform cleanup
cleanup() {
  echo "Cleaning up..."
  rm -rf "$temp_dir"
  echo "Cleanup complete. Exiting."
  exit 1
}

# Set up a trap for interrupt signal (Ctrl+C)
trap cleanup INT

# Determine the number of available CPU cores
cpu_cores=$(nproc)
half_cores=$((cpu_cores / 2))

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Prompt the user to choose the type of ISO to build
echo "Choose the type of ISO to build:"
echo "1. slim-iso"
echo "2. full-iso"
echo "3. all-iso"

# Read the user's choice
read -p "Enter your choice (1/2/3): " choice

# Set the iso_types array based on the user's choice
case $choice in
  1) iso_types=("slim-iso") ;;
  2) iso_types=("full-iso") ;;
  3) iso_types=("slim-iso" "full-iso") ;;
  *) echo "Invalid choice. Exiting." ; exit 1 ;;
esac

# Create a temporary directory for building the ISOs
temp_dir=$(mktemp -d)
echo "Using temporary directory: $temp_dir"

# Build each ISO type with specified build modes and redirect output and errors to a log file
for iso_type in "${iso_types[@]}"; do
  echo "Building $iso_type..."
  mkarchiso -v -w "$temp_dir/work" -o "$script_dir/out" "$iso_type" > >(tee "$script_dir/$iso_type'$(date +%Y.%m.%d)'.log") 2>&1
  echo "$iso_type build complete."
done

# Clean up the temporary directory
rm -rf "$temp_dir"

# Exit the script
exit
