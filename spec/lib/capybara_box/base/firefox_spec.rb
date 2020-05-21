require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.firefox?' do
  subject { described_class.new parameters }

  context 'when :browser is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it { expect(subject).to be_firefox }
  end

  context 'when :browser is not firefox' do
    let!(:parameters) { { browser: :not_firefox } }

    it { expect(subject).not_to be_firefox }
  end
end
