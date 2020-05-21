# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.register' do
  subject(:base) { described_class.new parameters }

  let!(:args) { { log_path: 'log/capybara-box.log', verbose: true } }
  let!(:service) { instance_double 'Selenium::WebDriver::Service' }

  before do
    allow(Selenium::WebDriver::Service).to receive(:chrome).with(args: args).and_return service
  end

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'uses the default driver options' do
      expect(base.driver_options).to eq(
        browser: :chrome,
        clear_local_storage: true,
        clear_session_storage: true,
        service: service
      )
    end

    context 'when :driver_options is given' do
      before { parameters[:driver_options] = { key: :value } }

      it 'is used' do
        expect(base.driver_options).to eq(key: :value)
      end
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'uses the default driver options' do
      expect(base.driver_options).to eq(
        browser: :chrome,
        clear_local_storage: true,
        clear_session_storage: true,
        service: service
      )
    end

    context 'when :driver_options is given' do
      before { parameters[:driver_options] = { key: :value } }

      it 'is used' do
        expect(base.driver_options).to eq(key: :value)
      end
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'uses the default driver options' do
      expect(base.driver_options).to eq(
        browser: :firefox,
        clear_local_storage: true,
        clear_session_storage: true
      )
    end

    context 'when :driver_options is given' do
      before { parameters[:driver_options] = { key: :value } }

      it 'is used' do
        expect(base.driver_options).to eq(key: :value)
      end
    end
  end
end
