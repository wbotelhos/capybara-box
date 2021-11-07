# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.add_preference' do
  subject { described_class.new parameters }

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'adds the argument' do
      subject.add_preference :key, :value

      expect(subject.capabilities.prefs).to eq(key: :value)
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'adds the argument' do
      subject.add_preference :key, :value

      expect(subject.capabilities.prefs).to eq(key: :value)
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'does not applies options' do
      subject.add_preference :key, :value

      expect(subject.capabilities).to eq nil
    end
  end
end
