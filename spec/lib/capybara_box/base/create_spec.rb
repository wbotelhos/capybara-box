# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '#create' do
  subject(:base) { described_class.new parameters }

  context 'with no parameters' do
    let!(:parameters) { {} }

    it 'applies the arguments' do
      expect(subject).to receive(:apply_arguments)

      base.create
    end

    it 'applies the preferences' do
      expect(subject).to receive(:apply_preferences)

      base.create
    end

    it 'register chrome browser as default' do
      expect(subject).to receive(:register).with(:selenium_chrome)

      base.create
    end

    it 'applies the capybara configurations' do
      expect(subject).to receive(:configure_capybara)

      base.create
    end
  end

  context 'when :bin_path is given' do
    let!(:parameters) { { bin_path: '/tmp/bin' } }

    it 'applies the bin path' do
      expect(subject).to receive(:apply_bin_path)

      base.create
    end
  end

  context 'when :version is given' do
    let!(:parameters) { { version: '2.31' } }

    it 'applies the version' do
      expect(subject).to receive(:apply_version)

      base.create
    end
  end

  context 'when :screenshot config is given' do
    let!(:parameters) { { browser: :chrome, screenshot: { key: 'value' } } }

    it 'applies the screenshot' do
      expect(::CapybaraBox::Screenshot).to receive(:configure).with({ key: 'value' }, :chrome)

      base.create
    end
  end

  context 'when :screenshot config is not given' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'applies the screenshot' do
      expect(::CapybaraBox::Screenshot).not_to receive(:configure)

      base.create
    end
  end

  context 'when :browser is given' do
    context 'as firefox' do
      let!(:parameters) { { browser: :firefox } }

      it 'registers the given browser' do
        expect(subject).to receive(:register).with(:firefox)

        base.create
      end
    end

    context 'as selenium_chrome_headless' do
      let!(:parameters) { { browser: :selenium_chrome_headless } }

      it 'registers the given browser' do
        expect(subject).to receive(:register).with :selenium_chrome_headless

        base.create
      end
    end
  end
end
