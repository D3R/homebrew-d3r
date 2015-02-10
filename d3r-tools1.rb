require 'formula'

class D3rTools < Formula
  homepage 'https://d3r.beanstalkapp.com/d3r-tools'
  url 'https://d3r.git.beanstalkapp.com/d3r-tools.git', :tag => 'v0.2'
  head 'https://d3r.git.beanstalkapp.com/d3r-tools.git', :branch => 'master'

  depends_on 'mysql'
  depends_on 'wget'
  depends_on 'nginx'
  depends_on 'php55' => ['with-fpm']
  depends_on 'php55-tidy'
  depends_on 'php55-xdebug'
  depends_on 'php55-mcrypt'
  depends_on 'php55-oauth' => :recommended
  depends_on 'php55-xcache' => :optional
  depends_on 'php55-memcache' => :optional
  depends_on 'elasticsearch' => :optional
  # depends_on 'composer' => :recommended

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
    # script_base_remote = "http://s3.apt.d3r.com/scripts"
    (sbin).mkpath
    scripts = ["d3r-scripts.functions", "d3r-fpm", "d3r-nginx"]
    scripts.each do |script|
      # system "wget -q -O #{sbin}/#{script} #{script_base_remote}/#{script}"
      system "cp src/scripts/osx/#{script} #{sbin}/#{script}"
    end

    # (bin).mkpath
    # system "mv src/scripts/d3r-tools #{bin}/#{script}"
    
    system "mv src/configurations/nginx/fpm-location.osx.conf src/configurations/nginx/fpm-location.conf"
    system "mv src/configurations/nginx/fpm-location-params.osx.conf src/configurations/nginx/fpm-location-params.conf"
    system "mv package.osx.config.php src/library/config.php"

    system "cat src/library/D3R/Version.php | sed \"s/%VERSION%/#{version}/\" > Version.php.tmp"
    system "mv Version.php.tmp src/library/D3R/Version.php"

    prefix.install Dir['src/*']

    system "rm #{prefix}/test.php"
    # (var+"d3r-tools").mkpath

  end

  plist_options :manual => 'd3r-tools'

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
           <string>#{HOMEBREW_PREFIX}/bin/php</string>
           <string>#{prefix}/receive.php</string>
           <string>nofork</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>UserName</key>
      <string>#{`whoami`.chomp}</string>
      <key>WorkingDirectory</key>
      <string>#{var}</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/d3r-tools.log</string>
    </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    You must run "php #{prefix}/register-server.php" to begin
    EOS
  end

end