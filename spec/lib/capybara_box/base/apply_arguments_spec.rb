# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.apply_arguments' do
  subject { described_class.new parameters }

  before do
    allow(subject).to receive(:arguments) { ['--argument'] }
  end

  context 'when is not chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'applies' do
      expect(subject.options.args).to eq []

      subject.apply_arguments

      expect(subject.options.args).to eq ['--argument']
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'applies' do
      expect(subject.options.args).to eq []

      subject.apply_arguments

      expect(subject.options.args).to eq ['--argument', '--headless', '--no-sandbox', '--disable-gpu']
    end
  end
end
