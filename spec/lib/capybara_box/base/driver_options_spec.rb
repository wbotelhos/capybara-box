require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.register' do
  subject { described_class.new parameters }

  context 'when is chrome' do
    let!(:parameters) { { browser: :chrome } }

    it 'uses the default driver options' do
      expect(subject.driver_options).to eq(
        browser:               :chrome,
        clear_local_storage:   true,
        clear_session_storage: true,
        driver_opts:           { log_path: 'log/capybara-box.log' }
      )
    end

    context 'when :driver_options is given' do
      before { parameters[:driver_options] = { key: :value } }

      it 'is used' do
        expect(subject.driver_options).to eq(key: :value)
      end
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    it 'uses the default driver options' do
      expect(subject.driver_options).to eq(
        browser:               :chrome,
        clear_local_storage:   true,
        clear_session_storage: true,
        driver_opts:           { log_path: 'log/capybara-box.log' }
      )
    end

    context 'when :driver_options is given' do
      before { parameters[:driver_options] = { key: :value } }

      it 'is used' do
        expect(subject.driver_options).to eq(key: :value)
      end
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'uses the default driver options' do
      expect(subject.driver_options).to eq(
        browser:               :firefox,
        clear_local_storage:   true,
        clear_session_storage: true
      )
    end

    context 'when :driver_options is given' do
      before { parameters[:driver_options] = { key: :value } }

      it 'is used' do
        expect(subject.driver_options).to eq(key: :value)
      end
    end
  end
end
