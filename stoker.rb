class Stoker < Formula
  homepage "https://github.com/D3R/stoker"
  url "http://d3r.assets.d3r.com/stoker.phar"
  # sha256 "1324deeb44035cb5c324742890c03f682b48c9f3c17889042c98ce2a27960d40"
  version "3.0.0"

  # option 'without-stack', "Build with stack"
  # if build.with? 'stack'
  #   depends_on 'mysql'
  #   depends_on 'wget'
  #   depends_on 'nginx'
  #   depends_on 'php55'
  #   depends_on 'php55-tidy'
  #   depends_on 'php55-xdebug'
  #   depends_on 'php55-mcrypt'
  #   depends_on 'php55-oauth' => :recommended
  #   depends_on 'php55-xcache' => :optional
  #   depends_on 'redis'
  #   depends_on 'php55-redis'
  #   depends_on 'elasticsearch' => :optional
  #   depends_on 'composer'
  # end
  # option 'without-imagemagick', "Build without imagemagick support"
  # if build.with? 'imagemagick'
  #   # depends_on 'imagemagick' => 'with-quantum-depth-8'
  #   depends_on 'imagemagick'
  #   depends_on 'php55-imagick'
  # end

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
