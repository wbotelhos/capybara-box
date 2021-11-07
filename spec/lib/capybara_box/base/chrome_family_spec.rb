# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.chrome_family?' do
  subject { described_class.new parameters }

  context 'when :browser is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it { expect(subject).to be_chrome_family }
  end

  context 'when :browser is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it { expect(subject).to be_chrome_family }
  end

  context 'when :browser is not chrome nor chrome headless' do
    let!(:parameters) { { browser: :firefox } }

    it { expect(subject).not_to be_chrome_family }
  end
end
