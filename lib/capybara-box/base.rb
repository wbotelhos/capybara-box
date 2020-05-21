# frozen_string_literal: true

module CapybaraBox
  require 'selenium/webdriver'

  class Base
    def initialize(parameters = {})
      @browser       = parameters.fetch(:browser) { :selenium_chrome }
      @max_wait_time = parameters[:max_wait_time]
      @parameters    = parameters
    end

    def add_argument(value)
      options.add_argument(value) if options
    end

    def add_preference(key, value)
      options.add_preference(key, value) if options
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
        require 'chromedriver/helper'

        ::Chromedriver.set_version version
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
      @browser == :chrome
    end

    def chrome_family?
      chrome? || chrome_headless?
    end

    def chrome_headless?
      @browser == :chrome_headless
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

    def configure_screenshot
      return false if @parameters[:screenshot].key?(:enabled) && !true?(@parameters[:screenshot][:enabled])

      require 'capybara-screenshot/rspec'

      Capybara::Screenshot.append_timestamp                                  = false
      Capybara::Screenshot.prune_strategy                                    = :keep_last_run
      Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = false

      Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
        example.full_description.downcase.gsub('#', '--').tr ' ', '-'
      end

      if @parameters[:screenshot][:s3]
        Capybara::Screenshot.s3_configuration = screenshot_s3_config
      end

      Capybara::Screenshot.register_driver(@browser) do |driver, path|
        driver.browser.save_screenshot path
      end
    end

    def create
      apply_arguments
      apply_preferences

      apply_bin_path @parameters[:bin_path] if @parameters[:bin_path]
      apply_version @parameters[:version]   if version?
      configure_screenshot                  if @parameters[:screenshot]

      register @browser

      configure
    end

    def driver(app)
      opts               = {}
      opts[:options]     = options if chrome_family?
      opts[:http_client] = http_client if true?(ENV['CI'])

      Capybara::Selenium::Driver.new app, opts.merge(driver_options)
    end

    def driver_options
      return @parameters[:driver_options] if @parameters[:driver_options]

      opts = {
        browser:               chrome_family? ? :chrome : @browser,
        clear_local_storage:   true,
        clear_session_storage: true
      }

      if log?
        if chrome_family?
          opts[:service] = Selenium::WebDriver::Service.chrome(args: {
            log_path: 'log/capybara-box.log',
            verbose: true,
          })
        end
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
        read_timeout: 120
      }
    end

    def http_client
      @http_client ||= Selenium::WebDriver::Remote::Http::Default.new(http_client_options)
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
          password_manager_enabled: false
        }
      }
    end

    def register(name)
      Capybara.register_driver name do |app|
        driver app
      end
    end

    def version
      if chrome_family?
        require 'chromedriver/helper'

        ::Chromedriver::Helper.new.current_version
      end
    end

    def self.configure(parameters)
      box = new(parameters)

      box.create

      box
    end

    private

    def log?
      return true if @parameters[:log].nil?

      true? @parameters[:log]
    end

    def true?(value)
      ['true', true].include? value
    end

    def screenshot_s3_config
      {
        s3_client_credentials: {
          access_key_id:     @parameters[:screenshot][:s3][:access_key_id],
          secret_access_key: @parameters[:screenshot][:s3][:secret_access_key]
        },

        bucket_name: @parameters[:screenshot][:s3][:bucket]
      }
    end

    def version?
      !!@parameters[:version]
    end
  end
end
