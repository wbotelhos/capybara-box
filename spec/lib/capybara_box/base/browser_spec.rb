require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.browser' do
  context 'when :browser is chrome family' do
    before do
      allow(subject).to receive(:chrome_family?) { true }
    end

    it 'is considered chrome' do
      expect(subject.browser).to eq :chrome
    end
  end

  context 'when :browser is not chrome family' do
    subject { described_class.new parameters }

    let!(:parameters) { { browser: :original_name } }

    before do
      allow(subject).to receive(:chrome_family?) { false }
    end

    it 'returns the original name' do
      expect(subject.browser).to eq :original_name
    end
  end
end
