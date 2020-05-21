# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.options' do
  subject { described_class.configure parameters }

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }
    let!(:options) { instance_double(Selenium::WebDriver::Chrome::Options).as_null_object }

    before { allow(Selenium::WebDriver::Chrome::Options).to receive(:new).with(no_args) { options } }

    it 'returns a instance of chrome options' do
      expect(subject.options).to eq options
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }
    let!(:options) { instance_double(Selenium::WebDriver::Chrome::Options).as_null_object }

    before { allow(Selenium::WebDriver::Chrome::Options).to receive(:new).with(no_args) { options } }

    it 'returns a instance of chrome options' do
      expect(subject.options).to eq options
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it { expect(subject.options).to eq nil }
  end
end
