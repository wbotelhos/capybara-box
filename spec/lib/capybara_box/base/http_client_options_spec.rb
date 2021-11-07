# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.http_client_options' do
  context 'when :http_client_options is not given' do
    subject { described_class.new }

    it 'returns the http client options' do
      expect(subject.http_client_options).to eq(
        open_timeout: nil,
        read_timeout: 120
      )
    end
  end

  context 'when :http_client_options is given' do
    subject { described_class.new parameters }

    let!(:parameters) { { http_client_options: { key: :value } } }

    it 'is used' do
      expect(subject.http_client_options).to eq(key: :value)
    end
  end
end
