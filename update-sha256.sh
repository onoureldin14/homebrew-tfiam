#!/bin/bash

# Script to update SHA256 hash and version in tfiam.rb

set -e

echo "🔍 Getting latest SHA256 hash from GitHub..."

# Get the SHA256 hash
SHA256=$(curl -L https://github.com/onoureldin14/tfiam/archive/refs/heads/main.zip | shasum -a 256 | cut -d' ' -f1)

echo "📝 SHA256: $SHA256"

# Get current version from tfiam.rb
CURRENT_VERSION=$(grep 'version "' tfiam.rb | sed 's/.*version "\(.*\)".*/\1/')
echo "📋 Current version: $CURRENT_VERSION"

# Bump version (patch version)
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

echo "🚀 Bumping version to: $NEW_VERSION"

# Update the version and SHA256 in tfiam.rb
echo "🔄 Updating version and SHA256 in tfiam.rb..."
sed -i.bak "s/version \"$CURRENT_VERSION\"/version \"$NEW_VERSION\"/" tfiam.rb
sed -i.bak "s/sha256 \".*\"/sha256 \"$SHA256\"/" tfiam.rb

# Remove the backup file
rm -f tfiam.rb.bak

echo "✅ Version and SHA256 updated successfully in tfiam.rb"
echo "📊 Changes:"
echo "   Version: $CURRENT_VERSION → $NEW_VERSION"
echo "   SHA256: $SHA256"
echo "🚀 Next steps:"
echo "1. Test the formula: brew audit tfiam.rb"
echo "2. Commit and push changes"
echo "3. Users can update with: brew upgrade tfiam"
