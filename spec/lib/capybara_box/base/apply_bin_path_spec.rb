require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.apply_bin_path' do
  subject { described_class.new parameters }

  before :all do
    File.open('/tmp/bin', 'w') { |file| file.write 'echo "capybara-box/bin"' }
    FileUtils.chmod(0755, '/tmp/bin')
  end

  context 'when is chrome' do
    let!(:parameters) { { browser: :chrome } }

    it 'does not apply' do
      expect(subject.apply_bin_path('/tmp/bin').nil?).to eq true
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :chrome_headless } }

    it 'does not apply' do
      expect(subject.apply_bin_path('/tmp/bin').nil?).to eq true
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'does not applies options' do
      expect(subject.apply_bin_path('/tmp/bin')).to eq '/tmp/bin'
    end
  end
end
