require 'formula'

class D3rTools < Formula
  homepage 'https://d3r.beanstalkapp.com/d3r-tools'
  head 'https://d3r.git.beanstalkapp.com/d3r-tools.git'

  depends_on 'php54'
  depends_on 'wget'

  def install
    system "chmod -R 770 ."

    script_base_remote = "http://s3.apt.d3r.com/scripts"

    (sbin).mkpath
    scripts = [ "d3r-scripts.functions", "d3r-apache2", "d3r-cron", "d3r-fpm", "d3r-nginx" ]
    scripts.each do |script|
      system "wget -q -O #{sbin}/#{script} #{script_base_remote}/#{script}"
    end

    system "mv src/configurations/nginx/fpm-location.osx.conf src/configurations/nginx/fpm-location.conf"
    system "mv src/configurations/nginx/fpm-location-params.osx.conf src/configurations/nginx/fpm-location-params.conf"
    system "mv package.osx.config.php src/lib/config.php"

    prefix.install Dir['src/*']

    (var).mkpath

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
           <string>#{opt_prefix}/bin/php</string>
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
      <string>/usr/local/bin/d3r-tools</string>
      <key>StandardErrorPath</key>
      <string>#{var}/d3r-tools/d3r-tools.log</string>
    </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    You must run "php #{prefix}/register-server.php" to begin
    EOS
  end

end
