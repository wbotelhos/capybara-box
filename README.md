# Capybara Box

[![Build Status](https://travis-ci.org/wbotelhos/capybara-box.svg)](https://travis-ci.org/wbotelhos/capybara-box)
[![Gem Version](https://badge.fury.io/rb/capybara-box.svg)](https://badge.fury.io/rb/capybara-box)

Configure Capybara with **Chrome**, **Chrome Headless** or **Firefox** with *Screenshot* feature and *Session* without losing your mind with just one line.

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

By default, `chrome` is the driver, but you can use `chrome_headless` and `firefox` too.

## Version

If you do not want install the Chrome Driver on your CI, you can specify the version here and it will be installed automatically for you.

```ruby
CapybaraBox::Base.configure version: '2.32'
```

* This works just for `chrome` and `chrome_headless`, for now

## Screenshot

You can enable screenshot on failure and send it to S3.

```ruby
CapybaraBox.configure(
  screenshot: {
    s3: {
      access_key_id:     'KEY',
      bucket:            'bucket',
      secret_access_key: 'SECRET'
    }
  }
)
```

If you want enable it only on CI, use the `enabled` option:

```ruby
CapybaraBox.configure(
  enabled: ENV['CI'],

  screenshot: { // ... }
)
```

## Session

By default, Rack Session manipulation comes as battery, just use it.

```ruby
page.set_rack_session key: 'value'
```

```ruby
page.get_rack_session :key
# 'value'
```

You can disable this feature using the `session` option:

```ruby
CapybaraBox.configure session: false
```

## Add Argument

By default some Switches are enabled for a better performance, you can add yours too:

```ruby
capybara_box = CapybaraBox.configure

capybara_box.add_argument '--incognito'
```

## Arguments

If you prefere, is possible override all of them:

```ruby
CapybaraBox.configure arguments: ['--incognito']
```

Click [here](https://peter.sh/experiments/chromium-command-line-switches) to see the avaiables.

## Add Preference

By default some Preferences are enabled for a better performance, you can add yours too:

```ruby
capybara_box = CapybaraBox.configure

capybara_box.add_preference :credentials_enable_service, false
```

## Preferences

If you prefere, is possible override all of them:

```ruby
CapybaraBox.configure preferences: { credentials_enable_service: false }
```

You can check [Chrome](https://sites.google.com/a/chromium.org/chromedriver/home) and [Firefox](http://preferential.mozdev.org/preferences.html).

## HTTP Client Options

By default some timeout configs are enabled only on CI env for a better performance.
It has this restrition because with timeout enabled, debugger cannot evaluate the variables values.
You can override all of them too:

```ruby
CapybaraBox.configure http_client_options: { read_timeout: 60 }
```

## Driver Options

You can override all driver options:

```ruby
CapybaraBox.configure driver_options: { clear_local_storage: true }
```

## Log

Log is writen at `log/capybara-box.log` as default.

You can see each command executed. Time spent between them and debug some hanging command. :tada:

```
[15.479][INFO]: RESPONSE Navigate
[15.482][INFO]: COMMAND ExecuteScript {
   "args": [  ],
   "script": "return $(\".gridy\").data(\"ready\")"
}
[15.483][INFO]: Waiting for pending navigations...
[15.545][INFO]: Done waiting for pending navigations. Status: ok
```

To disable log on CI, for example, use the `log` options:

```ruby
CapybaraBox.configure log: ENV['CI'].nil?
```

* It works only for **chrome** and **chrome_headless**.

## Love it!

Via [PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=X8HEP2878NDEG&item_name=capybara-box) or [Gratipay](https://gratipay.com/~wbotelhos). Thanks! (:
