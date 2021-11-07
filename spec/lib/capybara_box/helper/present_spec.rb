# frozen_string_literal: true

RSpec.describe CapybaraBox::Helper, '.present?' do
  context 'when blank is true' do
    it 'returns the oposite' do
      allow(described_class).to receive(:blank?).and_return(true)

      expect(described_class.present?('mocked')).to eq false
    end
  end

  context 'when blank is false' do
    it 'returns the oposite' do
      allow(described_class).to receive(:blank?).and_return(false)

      expect(described_class.present?('mocked')).to eq true
    end
  end
end
