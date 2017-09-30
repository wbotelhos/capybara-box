require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.configure' do
  subject { described_class.new parameters }

  let!(:parameters) { { browser: :driver } }

  it 'configure the javascript driver' do
    subject.configure

    expect(Capybara.javascript_driver).to eq :driver
  end

  context 'when max wait time is not given' do
    it 'does not writes and uses the default' do
      default = Capybara.default_max_wait_time

      subject.configure

      expect(Capybara.default_max_wait_time).to eq default
    end
  end

  context 'when max wait time is given' do
    before { parameters[:max_wait_time] = 7 }

    it 'is used' do
      subject.configure

      expect(Capybara.default_max_wait_time).to eq 7
    end
  end
end
