# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.add_argument' do
  subject(:base) { described_class.new parameters }

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'adds the argument' do
      base.add_argument '--argument'

      expect(base.options.args).to eq Set['--argument']
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'adds the argument' do
      base.add_argument '--argument'

      expect(base.options.args).to eq Set['--argument']
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'does not applies options' do
      base.add_argument '--argument'

      expect(base.options).to be_nil
    end
  end
end
