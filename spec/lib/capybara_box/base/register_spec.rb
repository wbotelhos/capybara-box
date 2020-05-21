# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.register' do
  subject { described_class.new }

  let!(:app) { double }

  before do
    allow(Capybara).to receive(:register_driver).with(:name).and_yield app
  end

  it 'register the driver with given name' do
    expect(subject).to receive(:driver).with app

    subject.register :name
  end
end
