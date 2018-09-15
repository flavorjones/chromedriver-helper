# [chromedriver-helper](http://github.com/flavorjones/chromedriver-helper)

[![Concourse CI](https://ci.nokogiri.org/api/v1/teams/nokogiri-core/pipelines/chromedriver-helper/jobs/ruby-2.5/badge)](https://ci.nokogiri.org/teams/nokogiri-core/pipelines/chromedriver-helper)

Easy installation and use of [`chromedriver`](https://sites.google.com/a/chromium.org/chromedriver/), the Chromium project's Selenium webdriver adapter.


# Description

`chromedriver-helper` installs an executable, `chromedriver-helper`, in your gem path, and configures Selenium to invoke it as the web driver.

This script will, if necessary, download the appropriate binary for your platform and install it into `~/.chromedriver-helper`, then exec it. Easy peasy!

Individual projects can even select which version of `chromedriver` they want to run.


# Usage

If you're using Bundler and Capybara, it's as easy as:

    # Gemfile
    gem "chromedriver-helper"

then, in your specs:

    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end


# Updating to latest `chromedriver`

You can always update to the latest version of `chromedriver`:

    chromedriver-update


## Having problems updating?

If for whatever reason you're having problems getting `chromedriver-helper` to update to the latest `chromedriver`, try this:

1. Delete the directory `$HOME/.chromedriver-helper`
2. Run `chromedriver-update`


# Specifying a version

If you want to run a specific version of `chromedriver` in your project, you can set the version in you testing setup like so:

    Chromedriver.set_version "2.24"

Or, from the command line, you can choose a system-wide default:

    chromedriver-update 2.24


# Support

The code lives at [http://github.com/flavorjones/chromedriver-helper](http://github.com/flavorjones/chromedriver-helper). Open a Github Issue, or send a pull request! Thanks! You're the best.


## CentOS 6 and 7

Apparently some versions of `chromedriver` won't run on CentOS 6 and 7, due to the [problems explained here](https://chrome.richardlloyd.org.uk/). The error messages look something like:

```
chromedriver: /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.15' not found (required by /home/vagrant/.chromedriver-helper/linux64/chromedriver)
chromedriver: /usr/lib64/libstdc++.so.6: version `CXXABI_1.3.5' not found (required by /home/vagrant/.chromedriver-helper/linux64/chromedriver)
chromedriver: /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.14' not found (required by /home/vagrant/.chromedriver-helper/linux64/chromedriver)

```

You can get `chromedriver` to work on these systems by running the `install_chrome.sh` script on the page linked to above, and then making sure your `chromedriver` process has `LD_LIBRARY_PATH` set so that `/opt/google/chrome/lib` is present, e.g.

```
$ LD_LIBRARY_PATH=/opt/google/chrome/lib chromedriver-helper
Starting ChromeDriver 2.28.455506 (18f6627e265f442aeec9b6661a49fe819aeeea1f) on port 9515
Only local connections are allowed.
```

# License

MIT licensed, see LICENSE.txt for full details.


# Credit

The idea for this gem comes from @brianhempel's project `chromedriver-gem` which, despite the name, is not currently published on http://rubygems.org/.

Some improvements on the idea were taken from the installation process for standalone Phusion Passenger.
