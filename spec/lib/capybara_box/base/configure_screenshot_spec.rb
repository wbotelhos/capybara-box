require 'rails_helper'
require 'capybara-screenshot'

RSpec.describe CapybaraBox::Base, '.configure_screenshot' do
  subject { described_class.new parameters }

  context 'when enabled tag is false' do
    let!(:parameters) { { screenshot: { enabled: false } } }

    it { expect(subject.configure_screenshot).to eq false }
  end

  context 'when enabled tag is "false"' do
    let!(:parameters) { { screenshot: { enabled: 'false' } } }

    it { expect(subject.configure_screenshot).to eq false }
  end

  context 'when enabled' do
    let!(:parameters) { { screenshot: {} } }

    it 'does not appends timestamp' do
      subject.configure_screenshot

      expect(Capybara::Screenshot.append_timestamp).to eq false
    end

    it 'prunes as keep_last_run' do
      subject.configure_screenshot

      expect(Capybara::Screenshot.prune_strategy).to eq :keep_last_run
    end

    it 'does not add link to screenshot on example description' do
      subject.configure_screenshot

      expect(Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples).to eq false
    end

    it 'configures a file name format for rspec' do
      subject.configure_screenshot

      example_object = OpenStruct.new(full_description: 'name#of file')
      block_object   = Capybara::Screenshot.filename_prefix_formatters[:rspec]

      expect(block_object.call example_object).to eq 'name--of-file'
    end

    it 'register a driver for given browser' do
      driver = double
      path   = '/tmp'

      subject.configure_screenshot

      expect(driver).to receive_message_chain(:browser, :save_screenshot).with path

      Capybara::Screenshot.registered_drivers[:chrome].call driver, path
    end

    context 'when s3 store is configured' do
      before do
        parameters[:screenshot][:s3] = {
          access_key_id:     :access_key_id,
          bucket:            :bucket,
          secret_access_key: :secret_access_key
        }
      end

      it 'configures the s3 metadata' do
        subject.configure_screenshot

        expect(Capybara::Screenshot.s3_configuration).to eq(
          s3_client_credentials: {
            access_key_id:     :access_key_id,
            secret_access_key: :secret_access_key
          },

          bucket_name: :bucket
        )
      end
    end
  end
end
