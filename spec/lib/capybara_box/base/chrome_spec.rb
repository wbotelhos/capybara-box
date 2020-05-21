require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.chrome?' do
  subject { described_class.new parameters }

  context 'when :browser is chrome' do
    let!(:parameters) { { browser: :chrome } }

    it { expect(subject).to be_chrome }
  end

  context 'when :browser is not chrome' do
    let!(:parameters) { { browser: :not_chrome } }

    it { expect(subject).not_to be_chrome }
  end
end
