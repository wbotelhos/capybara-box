# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.configure_capybara' do
  subject(:base) { described_class.new(parameters) }

  let!(:parameters) { { browser: :driver } }

  it 'configure the javascript driver' do
    base.configure_capybara

    expect(Capybara.javascript_driver).to eq :driver
  end

  context 'when max wait time is not given' do
    it 'does not writes and uses the default' do
      default = Capybara.default_max_wait_time

      base.configure_capybara

      expect(Capybara.default_max_wait_time).to eq default
    end
  end

  context 'when max wait time is given' do
    before { parameters[:max_wait_time] = 7 }

    it 'is used' do
      base.configure_capybara

      expect(Capybara.default_max_wait_time).to eq 7
    end
  end
end
