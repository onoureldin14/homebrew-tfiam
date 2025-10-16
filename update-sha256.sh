#!/bin/bash

# Script to update SHA256 hash in tfiam.rb

set -e

echo "🔍 Getting latest SHA256 hash from GitHub..."

# Get the SHA256 hash
SHA256=$(curl -L https://github.com/onoureldin14/tfiam/archive/refs/heads/main.zip | shasum -a 256 | cut -d' ' -f1)

echo "📝 SHA256: $SHA256"

# Update the formula file
if [ -f "tfiam.rb" ]; then
    # Create backup
    cp tfiam.rb tfiam.rb.backup
    
    # Update SHA256
    sed -i.tmp "s/sha256 \"PLACEHOLDER_SHA256\"/sha256 \"$SHA256\"/" tfiam.rb
    rm tfiam.rb.tmp
    
    echo "✅ Updated tfiam.rb with new SHA256 hash"
    echo "📋 Backup saved as tfiam.rb.backup"
else
    echo "❌ tfiam.rb not found in current directory"
    exit 1
fi

echo ""
echo "🚀 Next steps:"
echo "1. Test the formula: brew audit tfiam.rb"
echo "2. Commit and push changes"
echo "3. Users can update with: brew upgrade tfiam"
