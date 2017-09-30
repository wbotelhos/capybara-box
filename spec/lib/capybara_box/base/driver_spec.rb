require 'rails_helper'

RSpec.shared_context 'driver_with_options' do
  it 'creates the selenium driver with default options' do
    options           = subject.driver_options
    options[:options] = subject.options

    expect(Capybara::Selenium::Driver).to receive(:new).with(:app, options)

    subject.driver :app
  end
end

RSpec.shared_context 'driver_with_no_options' do
  it 'creates the selenium driver with no default options' do
    options = subject.driver_options

    expect(Capybara::Selenium::Driver).to receive(:new).with(:app, options)

    subject.driver :app
  end
end

RSpec.shared_context 'driver_with_options_and_http_client' do
  it 'adds http client options' do
    options               = subject.driver_options
    options[:options]     = subject.options
    options[:http_client] = subject.http_client

    expect(Capybara::Selenium::Driver).to receive(:new).with(:app, options)

    subject.driver :app
  end
end

RSpec.shared_context 'driver_with_not_options_but_with_http_client' do
  it 'adds http client options' do
    options               = subject.driver_options
    options[:http_client] = subject.http_client

    expect(Capybara::Selenium::Driver).to receive(:new).with(:app, options)

    subject.driver :app
  end
end

RSpec.describe CapybaraBox::Base, '.driver' do
  subject { described_class.new parameters }

  before { ENV['CI'] = 'false' }

  context 'when is chrome' do
    let!(:parameters) { { browser: :chrome } }

    it_behaves_like 'driver_with_options'

    context 'when env is CI' do
      before { ENV['CI'] = 'true' }

      it_behaves_like 'driver_with_options_and_http_client'
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    it_behaves_like 'driver_with_options'

    context 'when env is CI' do
      before { ENV['CI'] = 'true' }

      it_behaves_like 'driver_with_options_and_http_client'
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it_behaves_like 'driver_with_no_options'

    context 'when env is CI' do
      before { ENV['CI'] = 'true' }

      it_behaves_like 'driver_with_not_options_but_with_http_client'
    end
  end
end
