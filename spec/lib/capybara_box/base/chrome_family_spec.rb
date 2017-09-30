require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.chrome_family?' do
  subject { described_class.new parameters }

  context 'when :browser is chrome' do
    let!(:parameters) { { browser: :chrome } }

    specify { expect(subject).to be_chrome_family }
  end

  context 'when :browser is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    specify { expect(subject).to be_chrome_family }
  end

  context 'when :browser is not chrome nor chrome headless' do
    let!(:parameters) { { browser: :firefox } }

    specify { expect(subject).not_to be_chrome_family }
  end
end
