require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.apply_arguments' do
  subject { described_class.new parameters }

  before do
    allow(subject).to receive(:arguments) { Set['--argument'] }
  end

  context 'when is not chrome' do
    let!(:parameters) { { browser: :chrome } }

    it 'applies' do
      expect(subject.options.args).to eq Set.new

      subject.apply_arguments

      expect(subject.options.args).to eq Set['--argument']
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    it 'applies' do
      expect(subject.options.args).to eq Set.new

      subject.apply_arguments

      expect(subject.options.args).to eq Set['--argument', '--headless']
    end
  end
end
