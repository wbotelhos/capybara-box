# frozen_string_literal: true

module CapybaraBox
  class Base
    require 'selenium/webdriver'
    require 'webdrivers'

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

      add_argument('--headless') if chrome_headless?
    end

    def apply_preferences
      preferences.each { |key, value| add_preference(key, value) }
    end

    def apply_version(version)
      if chrome_family?
        Webdrivers::Chromedriver.required_version = version
      elsif Webdrivers::Geckodriver.required_version = version
      end
    end

    def arguments
      return @parameters[:arguments] if @parameters[:arguments]
      return [] unless chrome_family?

      %w[
        --disable-default-apps
        --disable-extensions
        --disable-infobars
        --disable-notifications
        --disable-password-generation
        --disable-password-manager-reauthentication
        --disable-password-separated-signin-flow
        --disable-popup-blocking
        --disable-save-password-bubble
        --disable-translate
        --incognito
        --mute-audio
        --no-default-browser-check
        --start-fullscreen
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

    def apply_bin_path(path)
      if firefox?
        Selenium::WebDriver::Firefox::Binary.path = path

        Selenium::WebDriver::Firefox::Binary.path
      end
    end

    def create
      apply_arguments
      apply_preferences

      apply_bin_path(@parameters[:bin_path]) if @parameters[:bin_path]
      apply_version(@parameters[:version])   if !!@parameters[:version]

      ::CapybaraBox::Screenshot.configure(@parameters[:screenshot], @browser) if @parameters[:screenshot]

      register(@browser)

      configure_capybara
    end

    def driver(app)
      opts               = {}
      opts[:options]     = options if chrome_family?
      opts[:http_client] = http_client if ::CapybaraBox::Helper.true?(ENV['CI'])

      Capybara::Selenium::Driver.new(app, opts.merge(driver_options))
    end

    def driver_options
      return @parameters[:driver_options] if @parameters[:driver_options]

      opts = {
        browser: chrome_family? ? :selenium_chrome : @browser,
        clear_local_storage: true,
        clear_session_storage: true,
      }

      if log? && chrome_family?
        opts[:service] = Selenium::WebDriver::Service.chrome(args: { log_path: 'log/capybara-box.log', verbose: true })
      end

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
      @http_client ||= Selenium::WebDriver::Remote::Http::Default.new(**http_client_options)
    end

    def options
      @options ||= Selenium::WebDriver::Chrome::Options.new if chrome_family?
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
      Capybara.register_driver(name) { |app| driver(app) }
    end

    def self.configure(parameters)
      new(parameters).tap(&:create)
    end

    private

    def log?
      return true if @parameters[:log].nil?

      ::CapybaraBox::Helper.true?(@parameters[:log])
    end
  end
end
