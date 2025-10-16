# Homebrew TFIAM Tap

This is the Homebrew tap repository for TFIAM - Terraform IAM Permission Analyzer.

## Installation

```bash
# Add the tap
brew tap onoureldin14/homebrew-tfiam

# Install TFIAM
brew install tfiam
```

## Usage

```bash
# Run TFIAM in interactive mode
tfiam

# Run with specific directory
tfiam /path/to/terraform/directory -ai

# Get help
tfiam --help
```

## Development

To update the formula:

1. Update the SHA256 hash in `tfiam.rb`:
   ```bash
   curl -L https://github.com/onoureldin14/tfiam/archive/refs/heads/main.zip | shasum -a 256
   ```

2. Update the version if needed

3. Test the formula:
   ```bash
   brew audit tfiam.rb
   brew install --build-from-source tfiam.rb
   ```

## Repository Structure

- `tfiam.rb` - Homebrew formula file
- `README.md` - This file

## Links

- Main Repository: https://github.com/onoureldin14/tfiam
- Homebrew Tap: https://github.com/onoureldin14/homebrew-tfiam
