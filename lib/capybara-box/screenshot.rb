# frozen_string_literal: true

module CapybaraBox
  module Screenshot
    module_function

    def configure(options, browser_name)
      return unless ::CapybaraBox::Helper.true?(options[:enabled])

      require 'capybara-screenshot/rspec'

      Capybara::Screenshot.append_timestamp                                  = false
      Capybara::Screenshot.prune_strategy                                    = :keep_last_run
      Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = false

      Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
        example.full_description.downcase.gsub('#', '--').tr ' ', '-'
      end

      if options[:s3]
        bucket_name = ENV.fetch('CAPYBARA_BOX__S3_BUCKET_NAME') { options[:s3][:bucket_name] }
        region      = ENV.fetch('CAPYBARA_BOX__S3_REGION') { options[:s3][:region] }

        Capybara::Screenshot.s3_configuration = {
          bucket_name: bucket_name,
          bucket_host: "#{bucket_name}.#{region}.amazonaws.com",

          s3_client_credentials: {
            access_key_id: ENV.fetch('CAPYBARA_BOX__S3_ACCESS_KEY_ID') { options[:s3][:access_key_id] },
            region: region,
            secret_access_key: ENV.fetch('CAPYBARA_BOX__S3_SECRET_ACCESS_KEY') { options[:s3][:secret_access_key] },
          },
        }
      end

      Capybara::Screenshot.register_driver(browser_name) do |driver, path|
        driver.browser.save_screenshot(path)
      end
    end
  end
end
