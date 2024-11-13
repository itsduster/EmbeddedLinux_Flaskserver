#!/bin/bash

# Define the project and virtual environment directories
PROJECT_DIR="$(pwd)"
VENV_DIR="$PROJECT_DIR/venv"

# Create a virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Install required packages
pip install --upgrade pip
pip install flask opencv-python-headless

# Create the capture folder if it doesn't exist
CAPTURE_FOLDER="$PROJECT_DIR/static/captured_images"
mkdir -p "$CAPTURE_FOLDER"

# Start the Flask app
echo "Starting Flask server..."
FLASK_APP="$PROJECT_DIR/app.py" FLASK_ENV=development flask run --host=0.0.0.0 --port=5000

# Deactivate the virtual environment after the app is stopped
deactivate
