# Capybara Box

[![CI](https://github.com/wbotelhos/capybara-box/workflows/CI/badge.svg)](https://github.com/wbotelhos/capybara-box/actions)
[![Gem Version](https://badge.fury.io/rb/capybara-box.svg)](https://badge.fury.io/rb/capybara-box)
[![Maintainability](https://api.codeclimate.com/v1/badges/f312587b4f126bb13e85/maintainability)](https://codeclimate.com/github/wbotelhos/capybara-box/maintainability)
[![Coverage](https://codecov.io/gh/wbotelhos/capybara-box/branch/main/graph/badge.svg)](https://codecov.io/gh/wbotelhos/capybara-box)
[![Sponsor](https://img.shields.io/badge/sponsor-%3C3-green)](https://github.com/sponsors/wbotelhos)

Configure Capybara with **Chrome**, **Chrome Headless**, **Firefox** and **Firefox Headless** with *Screenshot* feature without losing your mind.

## install

Add the following code on your Gemfile and run bundle install:

```ruby
group :test do
  gem 'capybara-box', require: false
end
```

## Usage

Just require the lib **after** Capybara require and you done:

```ruby
require 'capybara/rails'
require 'capybara-box'

CapybaraBox::Base.configure
```

By default, `selenium_chrome` is the driver, but you can use `selenium_chrome_headless` and `selenium_firefox` or `selenium_firefox_headless` too.

```ruby
CapybaraBox::Base.configure(browser: :selenium_firefox)
```

## Version

The version is setted via `webdrivers`. You can specify the version:

```ruby
CapybaraBox::Base.configure(version: '83.0.4103.39')
```

## Screenshot

You can enable screenshot on failure:

```ruby
CapybaraBox.configure(screenshot: { enabled: true })
```

If you want to send the screenshot and html page to S3 setup your credentials via ENV:

```sh
ENV['CAPYBARA_BOX__S3_BUCKET_NAME']
ENV['CAPYBARA_BOX__S3_REGION']
ENV['CAPYBARA_BOX__S3_ACCESS_KEY_ID']
ENV['CAPYBARA_BOX__S3_SECRET_ACCESS_KEY']
```

And then enable S3 feature:

```ruby
CapybaraBox.configure(screenshot: { enabled: true, s3: true })
```

## Add Argument

By default some Switches are enabled for a better performance, you can add yours too:

```ruby
capybara_box = CapybaraBox.configure

capybara_box.add_argument('--incognito')
```

## Arguments

If you prefere, is possible override all of them:

```ruby
CapybaraBox.configure(arguments: ['--incognito'])
```

Click [here](https://peter.sh/experiments/chromium-command-line-switches) to see the avaiables.

## Add Preference

By default some Preferences are enabled for a better performance, you can add yours too:

```ruby
capybara_box = CapybaraBox.configure

capybara_box.add_preference(:credentials_enable_service, false)
```

## Preferences

If you prefere, is possible override all of them:

```ruby
CapybaraBox.configure(preferences: { credentials_enable_service: false })
```

You can check [Chrome](https://sites.google.com/a/chromium.org/chromedriver/home) and [Firefox](http://preferential.mozdev.org/preferences.html).

## HTTP Client Options

By default some timeout configs are enabled only on CI env for a better performance.
It has this restrition because with timeout enabled, debugger cannot evaluate the variables values.
You can override all of them too:

```ruby
CapybaraBox.configure(http_client_options: { read_timeout: 60 })
```

## Driver Options

You can override all driver options:

```ruby
CapybaraBox.configure(driver_options: { clear_local_storage: true })
```

## Logger

Logs are writen as WARN on the `STDOUT` by default. You can change it:

```ruby
CapybaraBox.configure(logger: { level: :debug, output: 'log/selenium.log' })
```
