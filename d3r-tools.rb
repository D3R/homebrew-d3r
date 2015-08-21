class D3rTools < Formula
  homepage "https://github.com/D3R/wiki/blob/master/d3r-tools-2.md"
  url "http://d3r.assets.d3r.com/d3r-tools.phar"
  sha256 "1324deeb44035cb5c324742890c03f682b48c9f3c17889042c98ce2a27960d40"
  version "2.0.1"

  depends_on 'mysql'
  depends_on 'wget'
  depends_on 'nginx'
  depends_on 'php55'
  depends_on 'php55-tidy'
  depends_on 'php55-xdebug'
  depends_on 'php55-mcrypt'
  depends_on 'php55-oauth' => :recommended
  depends_on 'php55-xcache' => :optional
  depends_on 'php55-memcache' => :optional
  depends_on 'elasticsearch' => :optional
  depends_on 'composer'

  option 'without-redis', "Build without redis support"
  if build.with? 'redis'
    depends_on 'redis'
    depends_on 'php55-redis'
  end

  option 'without-imagemagick', "Build without imagemagick support"
  if build.with? 'imagemagick'
    # depends_on 'imagemagick' => 'with-quantum-depth-8'
    depends_on 'imagemagick'
    depends_on 'php55-imagick'
  end

  def install
    (bin).mkpath
    (etc).mkpath
    libexec.install "d3r-tools.phar"
    sh = libexec + "d3r-tools"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/d3r-tools.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system "d3r-tools", "--version"
  end

  def caveats; <<-EOS.undent
    To get going run

      d3r-tools self-update
      d3r-tools config:setup

    This will get you the latest version and set up your config.
    EOS
  end
end
