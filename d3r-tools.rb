class D3rTools < Formula
  homepage "https://wiki.d3r.com/doku.php?id=d3r-tools-2"
  url "http://d3r.assets.d3r.com/d3r-tools.phar"
  version "2.0"

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
    depends_on 'imagemagick' => 'with-quantum-depth-8'
    # depends_on 'imagemagick'
    depends_on 'php55-imagick'
  end

  def install
    (bin).mkpath
    (etc).mkpath
    touch "#{etc}/d3r-tools.ini"
    mv "d3r-tools.phar" "#{bin}/d3r-tools"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test d3r`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end

  def caveats; <<-EOS.undent
    To get going run

      d3r-tools self-update
      d3r-tools config:setup

    This will get you the latest version and set up your config.
    EOS
  end
end
