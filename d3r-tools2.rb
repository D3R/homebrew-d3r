require 'formula'

class D3rTools < Formula
  homepage 'https://wiki.d3r.com/doku.php?id=d3r-tools-2'
  url 'http://d3r.assets.d3r.com/d3r-tools.phar',

  # depends_on 'mysql'
  # depends_on 'wget'
  # depends_on 'nginx'
  # depends_on 'php55' => ['with-fpm']
  # depends_on 'php55-tidy'
  # depends_on 'php55-xdebug'
  # depends_on 'php55-mcrypt'
  # depends_on 'php55-oauth' => :recommended
  # depends_on 'php55-xcache' => :optional
  # depends_on 'php55-memcache' => :optional
  # depends_on 'elasticsearch' => :optional
  # depends_on 'composer'

  # option 'without-redis', "Build without redis support"
  # if build.with? 'redis'
  #   depends_on 'redis'
  #   depends_on 'php55-redis'
  # end

  # option 'without-imagemagick', "Build without imagemagick support"
  # if build.with? 'imagemagick'
  #   depends_on 'imagemagick' => 'with-quantum-depth-8'
  #   # depends_on 'imagemagick'
  #   depends_on 'php55-imagick'
  # end

  def install
    # script_base_remote = "http://s3.apt.d3r.com/scripts"
    (bin).mkpath

    system "mv d3r-tools.phar #{bin}/d3r-tools"

    prefix.install Dir['src/*']

    system "rm #{prefix}/test.php"
    # (var+"d3r-tools").mkpath

  end

  # plist_options :manual => 'd3r-tools'

  # def plist; <<-EOS.undent
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  #   <plist version="1.0">
  #   <dict>
  #     <key>Label</key>
  #     <string>#{plist_name}</string>
  #     <key>ProgramArguments</key>
  #     <array>
  #          <string>#{HOMEBREW_PREFIX}/bin/php</string>
  #          <string>#{prefix}/receive.php</string>
  #          <string>nofork</string>
  #     </array>
  #     <key>RunAtLoad</key>
  #     <true/>
  #     <key>KeepAlive</key>
  #     <true/>
  #     <key>UserName</key>
  #     <string>#{`whoami`.chomp}</string>
  #     <key>WorkingDirectory</key>
  #     <string>#{var}</string>
  #     <key>StandardErrorPath</key>
  #     <string>#{var}/log/d3r-tools.log</string>
  #   </dict>
  #   </plist>
  #   EOS
  # end

  def caveats; <<-EOS.undent
    Run d3r-tools config:setup to begin
    EOS
  end

end
