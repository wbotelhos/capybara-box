require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.chrome_headless?' do
  subject { described_class.new parameters }

  context 'when :browser is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    specify { expect(subject).to be_chrome_headless }
  end

  context 'when :browser is not chrome headless' do
    let!(:parameters) { { browser: :not_chrome_headless } }

    specify { expect(subject).not_to be_chrome_headless }
  end
end
