class Stoker < Formula
  homepage "https://github.com/D3R/stoker"
  url "http://d3r.assets.d3r.com/stoker.phar"
  version "0.1.7"

  depends_on 'composer'
  depends_on 'wget'

  option 'with-stack', "Build with stack"
  if build.with? 'stack'
    depends_on 'mysql'
    depends_on 'wget'
    depends_on 'homebrew/nginx/nginx-full' => 'with-status'
    depends_on 'homebrew/php/php55'
    depends_on 'homebrew/php/php55-tidy'
    depends_on 'homebrew/php/php55-xdebug'
    depends_on 'homebrew/php/php55-mcrypt'
    depends_on 'homebrew/php/php55-oauth' => :recommended
    depends_on 'homebrew/php/php55-xcache' => :optional
    depends_on 'redis'
    depends_on 'homebrew/php/php55-redis'
    depends_on 'imagemagick'
    depends_on 'homebrew/php/php55-imagick'
    depends_on 'elasticsearch' => :optional
  end

  def install
    (bin).mkpath
    (etc).mkpath
    libexec.install "stoker.phar"
    sh = libexec + "stoker"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/stoker.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system "stoker", "--version"
  end

  def caveats; <<-EOS.undent
    To get going run

      stoker self-update
      stoker config:setup

    This will get you the latest version and set up your config.
    EOS
  end
end
