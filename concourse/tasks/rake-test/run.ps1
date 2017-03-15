. "nokogiri-ci\concourse\shared\common.ps1"

prepend-path $ruby23_bin_path
$env:RUBYOPT = "-rdevkit"

push-location chromedriver-helper

    stream-cmd "gem" "install bundler"
    stream-cmd "bundle" "install"
    stream-cmd "bundle" "exec rake spec"

pop-location
