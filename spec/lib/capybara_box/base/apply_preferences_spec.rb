# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.apply_preferences' do
  subject { described_class.new parameters }

  before do
    allow(subject).to receive(:preferences).and_return({ key: :value })
  end

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'applies' do
      expect(subject.capabilities.prefs).to eq({})

      subject.apply_preferences

      expect(subject.capabilities.prefs).to eq(key: :value)
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'applies' do
      expect(subject.capabilities.prefs).to eq({})

      subject.apply_preferences

      expect(subject.capabilities.prefs).to eq(key: :value)
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'does not applies capabilities' do
      subject.apply_preferences

      expect(subject.capabilities).to eq nil
    end
  end
end
