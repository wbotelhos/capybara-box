# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'log_disabled' do
  context 'when is chrome' do
    before { parameters[:browser] = :selenium_chrome }

    it 'does not includes log config' do
      expect(subject.driver_options[:driver_opts]).to be_nil
    end
  end

  context 'when is chrome headless' do
    before { parameters[:browser] = :selenium_chrome_headless }

    it 'does not includes log config' do
      expect(subject.driver_options[:driver_opts]).to be_nil
    end
  end

  context 'when is firefox' do
    before { parameters[:browser] = :firefox }

    it 'does not includes log config' do
      expect(subject.driver_options[:driver_opts]).to be_nil
    end
  end
end

RSpec.describe CapybaraBox::Base, '.log' do
  subject { described_class.new parameters }

  context 'when log is false' do
    let!(:parameters) { { log: false } }

    it_behaves_like 'log_disabled'
  end

  context 'when log is "false"' do
    let!(:parameters) { { log: 'false' } }

    it_behaves_like 'log_disabled'
  end
end
