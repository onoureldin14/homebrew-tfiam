class Tfiam < Formula
  desc "TFIAM - Analyze Terraform repositories and generate IAM permission recommendations with AI explanations"
  homepage "https://github.com/onoureldin14/tfiam"
  url "https://github.com/onoureldin14/tfiam/archive/refs/heads/main.zip"
  version "1.1.0"
  sha256 "294f2f6181bf6d18ba11257f7da8fea146253b403d478cf7e469c8a940388a94"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Create a virtual environment using python -m venv
    system "python3.11", "-m", "venv", "#{libexec}/venv"
    
    # Install Python dependencies into the virtual environment
    system "#{libexec}/venv/bin/pip", "install", "openai>=1.0.0", "pbr>=1.7.5"
    
    # Copy the entire project to libexec
    cp_r buildpath, libexec/"tfiam"
    
    # Create a wrapper script that uses the virtual environment and preserves working directory
    (bin/"tfiam").write <<~EOS
      #!/bin/bash
      # Save the current working directory
      ORIGINAL_DIR="$(pwd)"
      # Change to the tfiam directory to run the script
      cd "#{libexec}/tfiam"
      # Run the script with the original working directory as an environment variable
      ORIGINAL_WORKING_DIR="$ORIGINAL_DIR" exec "#{libexec}/venv/bin/python" "main.py" "$@"
    EOS
    
    chmod 0755, bin/"tfiam"
  end

  test do
    system "#{bin}/tfiam", "--help"
  end
end