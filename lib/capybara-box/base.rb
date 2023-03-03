# frozen_string_literal: true

module CapybaraBox
  class Base
    def initialize(parameters = {})
      @browser       = parameters.fetch(:browser) { :selenium_chrome }
      @max_wait_time = parameters[:max_wait_time]
      @parameters    = parameters
    end

    def add_argument(value)
      options&.add_argument(value)
    end

    def add_preference(key, value)
      options&.add_preference(key, value)
    end

    def apply_arguments
      arguments.each { |argument| add_argument(argument) }

      if chrome_headless?
        add_argument('--headless')
        add_argument('--no-sandbox')
        add_argument('--disable-gpu')
      end
    end

    def apply_bin_path(path)
      if firefox?
        ::Selenium::WebDriver::Firefox.path = path

        ::Selenium::WebDriver::Firefox.path
      end
    end

    def apply_preferences
      preferences.each { |key, value| add_preference(key, value) }
    end

    def apply_version(version)
      if chrome_family?
        Webdrivers::Chromedriver.required_version = version
      else
        Webdrivers::Geckodriver.required_version = version
      end
    end

    def arguments
      return @parameters[:arguments] if @parameters[:arguments]
      return [] unless chrome_family?

      %w[
        --disable-background-networking
        --disable-default-apps
        --disable-dev-shm-usage
        --disable-extensions
        --disable-infobars
        --disable-notifications
        --disable-password-generation
        --disable-password-manager-reauthentication
        --disable-password-separated-signin-flow
        --disable-popup-blocking
        --disable-save-password-bubble
        --disable-site-isolation-trials
        --disable-sync
        --disable-translate
        --hide-scrollbars
        --incognito
        --metrics-recording-only
        --mute-audio
        --no-default-browser-check
        --no-first-run
        --safebrowsing-disable-auto-update
        --start-fullscreen
        --window-size=1920,1080
      ]
    end

    def chrome?
      @browser == :selenium_chrome
    end

    def chrome_family?
      chrome? || chrome_headless?
    end

    def chrome_headless?
      @browser == :selenium_chrome_headless
    end

    def configure_capybara
      Capybara.javascript_driver     = @browser
      Capybara.default_max_wait_time = @max_wait_time if @max_wait_time
    end

    def create
      apply_arguments
      apply_preferences

      apply_bin_path(@parameters[:bin_path]) if ::CapybaraBox::Helper.present?(@parameters[:bin_path])
      apply_version(@parameters[:version])   if ::CapybaraBox::Helper.present?(@parameters[:version])

      ::CapybaraBox::Screenshot.configure(@parameters[:screenshot], @browser) if @parameters[:screenshot]

      register(@browser)

      configure_capybara
      configure_logger(@parameters[:logger]) if logger?
    end

    def driver(app)
      opts                = {}
      opts[:options] = options if chrome_family?

      Capybara::Selenium::Driver.load_selenium

      opts[:http_client] = http_client if ::CapybaraBox::Helper.true?(ENV['CI'])

      Capybara::Selenium::Driver.new(app, **opts.merge(driver_options))
    end

    def driver_options
      return @parameters[:driver_options] if @parameters[:driver_options]

      opts = {
        browser: chrome_family? ? :chrome : @browser,
        clear_local_storage: true,
        clear_session_storage: true,
      }

      opts
    end

    def firefox?
      @browser == :firefox
    end

    def http_client_options
      return @parameters[:http_client_options] if @parameters[:http_client_options]

      {
        open_timeout: nil,
        read_timeout: 120,
      }
    end

    def http_client
      @http_client ||= ::Selenium::WebDriver::Remote::Http::Default.new(**http_client_options)
    end

    def options
      @options ||= ::Selenium::WebDriver::Chrome::Options.new if chrome_family?
    end

    def preferences
      return @parameters[:preferences] if @parameters[:preferences]
      return {} unless chrome_family?

      {
        credentials_enable_service: false,

        profile: {
          password_manager_enabled: false,
        },
      }
    end

    def register(name)
      Capybara.register_driver(name.to_sym) { |app| driver(app) }
    end

    def self.configure(parameters = {})
      new(parameters).tap(&:create)
    end

    private

    # https://www.selenium.dev/documentation/webdriver/troubleshooting/logging/#ruby
    def configure_logger(options)
      Selenium::WebDriver.logger.level = options.fetch(:level, :warn)
      Selenium::WebDriver.logger.output = options.fetch(:output, 'selenium.log')
    end

    def logger?
      @parameters.key?(:logger)
    end
  end
end
