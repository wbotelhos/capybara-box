# Capybara Box

[![Build Status](https://travis-ci.org/wbotelhos/capybara-box.svg)](https://travis-ci.org/wbotelhos/capybara-box)
[![Gem Version](https://badge.fury.io/rb/capybara-box.svg)](https://badge.fury.io/rb/capybara-box)

Configure Capybara with **Chrome**, **Headless Chrome** or **Firefox** with *Screenshot* feature and *Session* without lost your mind with just one line.

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

By default, `chrome` is de driver, but you can use `chrome`, `chrome_headless` or `firefox`.

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
CapybaraBox.configure browser: :chrome, session: false
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

## Love it!

Via [PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=X8HEP2878NDEG&item_name=capybara-box) or [Gratipay](https://gratipay.com/~wbotelhos). Thanks! (:
