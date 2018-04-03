require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.add_argument' do
  subject { described_class.new parameters }

  context 'when is chrome' do
    let!(:parameters) { { browser: :chrome } }

    it 'adds the argument' do
      subject.add_argument '--argument'

      expect(subject.options.args).to eq Set['--argument']
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    it 'adds the argument' do
      subject.add_argument '--argument'

      expect(subject.options.args).to eq Set['--argument']
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'does not applies options' do
      subject.add_argument '--argument'

      expect(subject.options).to be_nil
    end
  end
end
