require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.http_client' do
  before do
    allow(Selenium::WebDriver::Remote::Http::Default).to receive(:new).with(subject.http_client_options) { :client }
  end

  it 'returns the default http client' do
    expect(subject.http_client).to eq :client
  end
end
