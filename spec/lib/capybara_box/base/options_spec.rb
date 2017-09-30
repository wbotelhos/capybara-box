require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.options' do
  subject { described_class.configure parameters }

  context 'when is chrome' do
    let!(:parameters) { { browser: :chrome } }

    let!(:options) do
      instance_double(Selenium::WebDriver::Chrome::Options).as_null_object
    end

    before do
      allow(Selenium::WebDriver::Chrome::Options).to receive(:new).with(no_args) { options }
    end

    it 'returns a instance of chrome options' do
      expect(subject.options).to eq options
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    let!(:options) do
      instance_double(Selenium::WebDriver::Chrome::Options).as_null_object
    end

    before do
      allow(Selenium::WebDriver::Chrome::Options).to receive(:new).with(no_args) { options }
    end

    it 'returns a instance of chrome options' do
      expect(subject.options).to eq options
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    specify { expect(subject.options).to be_nil }
  end
end
