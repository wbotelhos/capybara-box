require 'rails_helper'

RSpec.describe CapybaraBox::Base, '#create' do
  context 'with no parameters' do
    it 'applies the arguments' do
      expect(subject).to receive(:apply_arguments)

      subject.create
    end

    it 'applies the preferences' do
      expect(subject).to receive(:apply_preferences)

      subject.create
    end

    it 'register chrome browser as default' do
      expect(subject).to receive(:register).with :chrome

      subject.create
    end

    it 'applies the capybara configurations' do
      expect(subject).to receive :configure

      subject.create
    end
  end

  context 'when :bin_path is given' do
    subject { described_class.new parameters }

    let!(:parameters) { { bin_path: '/tmp/bin' } }

    it 'applies the bin path' do
      expect(subject).to receive(:apply_bin_path)

      subject.create
    end
  end

  context 'when :version is given' do
    subject { described_class.new parameters }

    let!(:parameters) { { version: '2.31' } }

    it 'applies the version' do
      expect(subject).to receive(:apply_version)

      subject.create
    end
  end

  context 'when :screenshot config is given' do
    subject { described_class.new parameters }

    let!(:parameters) { { screenshot: {} } }

    it 'applies the screenshot' do
      expect(subject).to receive(:configure_screenshot)

      subject.create
    end
  end

  context 'when :browser is given' do
    subject { described_class.new parameters }

    context 'as firefox' do
      let!(:parameters) { { browser: :firefox } }

      it 'registers the given browser' do
        expect(subject).to receive(:register).with :firefox

        subject.create
      end
    end

    context 'as chrome_headless' do
      let!(:parameters) { { browser: :chrome_headless } }

      it 'registers the given browser' do
        expect(subject).to receive(:register).with :chrome_headless

        subject.create
      end
    end
  end
end
