#!/bin/bash

# Function to perform cleanup
cleanup() {
  echo "Cleaning up..."
  sudo rm -rf work/*
  echo "Cleanup complete. Exiting."
  exit 1
}

# Set up a trap for interrupt signal (Ctrl+C)
trap cleanup INT

# Prompt the user to choose the type of ISO to build
echo "Choose the type of ISO to build:"
echo "1. slim-iso"
echo "2. full-iso"
echo "3. all-iso"

# Read the user's choice
read -p "Enter your choice (1/2/3/): " choice

# Set the iso_type variable based on the user's choice
case $choice in
  1) iso_type="slim-iso" ;;
  3) iso_type="full-iso" ;;
  4) iso_type="all-iso" ;;
  *) echo "Invalid choice. Exiting." ; exit 1 ;;
esac

# Ask the user if they want to copy the output to a file
read -p "Do you want to copy the output to a file? (y/n): " copy_output

# Define the output file name
output_file="output.log"

# Run the mkarchiso command with the chosen ISO type
if [[ "$copy_output" == "y" ]]; then
  sudo mkarchiso -v -w work -o out "$iso_type" &> "$output_file"
else
  sudo mkarchiso -v -w work -o out "$iso_type"
fi

# Clean up the work directory
sudo rm -rf work/*

# Exit the script
exit

