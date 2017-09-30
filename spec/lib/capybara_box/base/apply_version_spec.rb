require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.apply_version' do
  subject { described_class.new parameters }

  context 'when browser is chrome' do
    let!(:parameters) { { browser: :chrome } }

    it 'is used' do
      subject.apply_version '2.31'

      expect(subject.version).to eq '2.31'
    end
  end

  context 'when browser is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    it 'is used' do
      subject.apply_version '2.31'

      expect(subject.version).to eq '2.31'
    end
  end

  context 'when browser is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'does not applies options' do
      subject.apply_preferences

      expect(subject.options).to be_nil
    end
  end
end
