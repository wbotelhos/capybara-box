## v1.0.0

- Updates
  - Updated default arguments;
  - Spec files now is excluded from gem pack;

- Features
  - Capybara `load_selenium` is called before startup;
  - Screenshot S3 feature now is configure only via ENV;
  - Using new gem `webdrivers`;

- Fixes
  - Fix screenshot upload;

## v0.4.0

- Updates Selenium WebDriver deprecated message;

## v0.3.0

- Drops Rack Session Access internal require;
- Makes `chromedriver-helper` optional.

## v0.2.1

- Fixes
  - `chrome_headless` was being registered with wrong name.

## v0.2.0

- Features
  - Add log feature for Chrome and Chrome Headless.

## v0.1.0

First release.
