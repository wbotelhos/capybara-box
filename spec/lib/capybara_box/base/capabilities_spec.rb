# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.capabilities' do
  subject { described_class.configure parameters }

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }
    let!(:capabilities) { instance_double(Selenium::WebDriver::Chrome::Options).as_null_object }

    before { allow(Selenium::WebDriver::Chrome::Options).to receive(:new).with(no_args) { capabilities } }

    it 'returns a instance of chrome capabilities' do
      expect(subject.capabilities).to eq capabilities
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }
    let!(:capabilities) { instance_double(Selenium::WebDriver::Chrome::Options).as_null_object }

    before { allow(Selenium::WebDriver::Chrome::Options).to receive(:new).with(no_args) { capabilities } }

    it 'returns a instance of chrome capabilities' do
      expect(subject.capabilities).to eq capabilities
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it { expect(subject.capabilities).to eq nil }
  end
end
