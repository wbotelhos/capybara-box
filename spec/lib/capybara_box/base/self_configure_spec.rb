require 'rails_helper'

RSpec.describe CapybaraBox::Base, '#configure' do
  let!(:parameters) { { key: :value } }
  let!(:box)        { instance_double(CapybaraBox::Base).as_null_object }

  before do
    allow(described_class).to receive(:new).with(parameters) { box }
  end

  it 'creates the box with given parameters' do
    expect(box).to receive :create

    described_class.configure parameters
  end

  it 'returns the created box' do
    expect(described_class.configure(parameters)).to eq box

    described_class.configure parameters
  end
end
