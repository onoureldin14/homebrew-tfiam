class Tfiam < Formula
  desc "TFIAM - Analyze Terraform repositories and generate IAM permission recommendations with AI explanations"
  homepage "https://github.com/onoureldin14/tfiam"
  url "https://github.com/onoureldin14/tfiam/archive/refs/heads/main.zip"
  version "1.0.0"
  sha256 "c62482dec4b963af3d4a365abfeab5e9509b3b7a13c171601591087aff480c4b"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Create virtual environment
    venv = virtualenv_create(libexec, "python3.11")
    
    # Install Python dependencies
    venv.pip_install "openai>=1.0.0"
    venv.pip_install "pbr>=1.7.5"
    
    # Copy the entire project to libexec
    cp_r buildpath, libexec/"tfiam"
    
    # Create a wrapper script that uses the virtual environment
    (bin/"tfiam").write <<~EOS
      #!/bin/bash
      cd "#{libexec}/tfiam"
      exec "#{libexec}/bin/python" "main.py" "$@"
    EOS
    
    chmod 0755, bin/"tfiam"
  end

  test do
    system "#{bin}/tfiam", "--help"
  end
end