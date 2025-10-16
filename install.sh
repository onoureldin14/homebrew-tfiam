#!/bin/bash

# TFIAM Homebrew Installation Script

set -e

echo "🍺 Installing TFIAM via Homebrew..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install Homebrew first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Add the tap
echo "📦 Adding TFIAM tap..."
brew tap onoureldin14/homebrew-tfiam

# Install TFIAM
echo "🚀 Installing TFIAM..."
brew install tfiam

# Test installation
echo "✅ Testing installation..."
if tfiam --help &> /dev/null; then
    echo "🎉 TFIAM installed successfully!"
    echo ""
    echo "Usage:"
    echo "  tfiam                    # Interactive mode"
    echo "  tfiam /path/to/tf        # Analyze specific directory"
    echo "  tfiam --help             # Show help"
else
    echo "❌ Installation failed. Please check the error messages above."
    exit 1
fi
