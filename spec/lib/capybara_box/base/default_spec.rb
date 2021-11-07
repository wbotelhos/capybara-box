# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.configure' do
  subject { described_class.configure }

  context 'when parameters are not given' do
    it 'returns a instance of chrome options' do
      expect(subject.chrome?).to eq true
    end
  end
end
