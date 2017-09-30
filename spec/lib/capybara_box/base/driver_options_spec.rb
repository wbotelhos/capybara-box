require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.register' do
  subject { described_class.new parameters }

  let!(:parameters) { { browser: :browser } }

  it 'returns the driver options' do
    expect(subject.driver_options).to eq(
      browser:               :browser,
      clear_local_storage:   true,
      clear_session_storage: true
    )
  end

  context 'when :driver_options is given' do
    let!(:parameters) { { driver_options: { key: :value }, browser: :browser } }

    it 'is used' do
      expect(subject.driver_options).to eq(key: :value)
    end
  end
end
