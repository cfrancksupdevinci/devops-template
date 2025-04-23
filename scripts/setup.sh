#!/bin/bash
# filepath: scripts/setup.sh

echo "Initializing project setup..."

# Install dependencies
echo "Installing dependencies..."
npm install || pip install -r requirements.txt

# Set up environment variables
echo "Setting up environment variables..."
cp .env.example .env

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

echo "Project setup complete!"

if [ -f .env.example ]; then
  cp .env.example .env
  echo "Environment variables set up successfully."
else
  echo "Warning: .env.example file not found. Skipping environment setup."
fi