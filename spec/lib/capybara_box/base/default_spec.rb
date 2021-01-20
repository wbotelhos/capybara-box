# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.configure' do
  subject { described_class.configure }

  context 'when parameters are not given' do
    it 'returns a instance of chrome options' do
      expect(subject.chrome?).to eq true
    end
  end
end
