# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.apply_version' do
  subject(:base) { described_class.new parameters }

  context 'when browser is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'is used' do
      base.apply_version('2.31')

      expect(Webdrivers::Chromedriver.required_version.version).to eq '2.31'
    end
  end

  context 'when browser is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'is used' do
      base.apply_version('2.31')

      expect(Webdrivers::Chromedriver.required_version.version).to eq '2.31'
    end
  end

  context 'when browser is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'does not applies options' do
      base.apply_version('2.31')

      expect(Webdrivers::Geckodriver.required_version.version).to eq '2.31'
    end
  end
end
