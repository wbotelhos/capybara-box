# frozen_string_literal: true

require 'rails_helper'
require 'capybara-screenshot'

RSpec.describe CapybaraBox::Screenshot, '.configure(options, browser)' do
  let!(:browser) { :selenium_chrome }

  context 'when enabled tag is false' do
    let!(:options) { { enabled: false } }

    it { expect(described_class.configure(options, browser)).to eq nil }
  end

  context 'when enabled tag is "false"' do
    let!(:options) { { enabled: 'false' } }

    it { expect(described_class.configure(options, browser)).to eq nil }
  end

  context 'when enabled' do
    let!(:options) { { enabled: true } }

    it 'does not appends timestamp' do
      described_class.configure(options, browser)

      expect(Capybara::Screenshot.append_timestamp).to eq false
    end

    it 'prunes as keep_last_run' do
      described_class.configure(options, browser)

      expect(Capybara::Screenshot.prune_strategy).to eq :keep_last_run
    end

    it 'does not add link to screenshot on example description' do
      described_class.configure(options, browser)

      expect(Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples).to eq false
    end

    it 'configures a file name format for rspec' do
      described_class.configure(options, browser)

      example_object = OpenStruct.new(full_description: 'name#of file')
      block_object   = Capybara::Screenshot.filename_prefix_formatters[:rspec]

      expect(block_object.call(example_object)).to eq 'name--of-file'
    end

    it 'register a driver for given browser' do
      driver = double
      path   = '/tmp'

      expect(Capybara::Screenshot).to receive(:register_driver).with(:selenium_chrome).and_yield(driver, path)
      expect(driver).to receive_message_chain(:browser, :save_screenshot).with(path)

      described_class.configure(options, browser)
    end

    context 'configures s3 via env' do
      it 'configures the s3 metadata' do
        options[:s3] = true

        ENV['CAPYBARA_BOX__S3_ACCESS_KEY_ID']     = 'access_key_id'
        ENV['CAPYBARA_BOX__S3_BUCKET_NAME']       = 'bucket_name'
        ENV['CAPYBARA_BOX__S3_REGION']            = 'us-east-1'
        ENV['CAPYBARA_BOX__S3_SECRET_ACCESS_KEY'] = 'secret_access_key'

        described_class.configure(options, browser)

        expect(Capybara::Screenshot.s3_configuration).to eq(
          bucket_name: 'bucket_name',
          bucket_host: 'bucket_name.us-east-1.amazonaws.com',

          s3_client_credentials: {
            access_key_id: 'access_key_id',
            region: 'us-east-1',
            secret_access_key: 'secret_access_key',
          }
        )
      ensure
        ENV.delete('CAPYBARA_BOX__S3_ACCESS_KEY_ID')
        ENV.delete('CAPYBARA_BOX__S3_BUCKET_NAME')
        ENV.delete('CAPYBARA_BOX__S3_REGION')
        ENV.delete('CAPYBARA_BOX__S3_SECRET_ACCESS_KEY')
      end
    end
  end
end