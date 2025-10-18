#!/bin/bash

# Script to update SHA256 hash in tfiam.rb

set -e

echo "🔍 Getting latest SHA256 hash from GitHub..."

# Get the SHA256 hash
SHA256=$(curl -L https://github.com/onoureldin14/tfiam/archive/refs/heads/main.zip | shasum -a 256 | cut -d' ' -f1)

echo "📝 SHA256: $SHA256"

# Update the SHA256 in tfiam.rb
echo "🔄 Updating SHA256 in tfiam.rb..."
sed -i.bak "s/sha256 \".*\"/sha256 \"$SHA256\"/" tfiam.rb

# Remove the backup file
rm -f tfiam.rb.bak

echo "✅ SHA256 updated successfully in tfiam.rb"
echo "🚀 Next steps:"
echo "1. Test the formula: brew audit tfiam.rb"
echo "2. Commit and push changes"
echo "3. Users can update with: brew upgrade tfiam"
