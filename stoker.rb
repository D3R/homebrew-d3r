class Stoker < Formula
  desc "D3R deployment management tools"
  homepage "https://github.com/D3R/stoker"
  url "http://d3r.assets.d3r.com/stoker.phar"
  version "0.2.0"

  depends_on "wget"

  def install
    bin.mkpath
    etc.mkpath
    libexec.install "stoker.phar"
    sh = libexec + "stoker"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/stoker.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats
    <<~EOS
      To get going run

      stoker self-update
      stoker config:setup

      This will get you the latest version and set up your config.
    EOS
  end

  test do
    system "stoker", "--version"
  end
end
