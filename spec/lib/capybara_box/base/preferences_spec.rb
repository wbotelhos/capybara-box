# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.preferences' do
  subject { described_class.new parameters }

  let!(:chrome_family_preferences) do
    {
      credentials_enable_service: false,

      profile: {
        password_manager_enabled: false,
      },
    }
  end

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'receives the right preferences' do
      expect(subject.preferences).to eq chrome_family_preferences
    end

    context 'and :preferences is given' do
      before { parameters[:preferences] = { key: :value } }

      it 'is used' do
        expect(subject.preferences).to eq(key: :value)
      end
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'receives the right preferences' do
      expect(subject.preferences).to eq chrome_family_preferences
    end

    context 'and :preferences is given' do
      before { parameters[:preferences] = { key: :value } }

      it 'is used' do
        expect(subject.preferences).to eq(key: :value)
      end
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'receives the right preferences' do
      expect(subject.preferences).to eq({})
    end

    context 'and :preferences is given' do
      before { parameters[:preferences] = { key: :value } }

      it 'is used' do
        expect(subject.preferences).to eq(key: :value)
      end
    end
  end
end
