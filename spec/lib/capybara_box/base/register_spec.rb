# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.register' do
  subject(:base) { described_class.new }

  let!(:app) { double('app') }

  before { allow(Capybara).to receive(:register_driver).with(:name).and_yield(app) }

  it 'register the driver with given name' do
    expect(base).to receive(:driver).with app

    base.register(:name)
  end

  it 'converts name to symbol' do
    expect(base).to receive(:driver).with app

    base.register('name')
  end
end
