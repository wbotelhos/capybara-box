# frozen_string_literal: true

RSpec.describe CapybaraBox::Base, '.arguments' do
  subject { described_class.new parameters }

  let!(:chrome_family_arguments) do
    %w[
      --disable-background-networking
      --disable-default-apps
      --disable-dev-shm-usage
      --disable-extensions
      --disable-infobars
      --disable-notifications
      --disable-password-generation
      --disable-password-manager-reauthentication
      --disable-password-separated-signin-flow
      --disable-popup-blocking
      --disable-save-password-bubble
      --disable-site-isolation-trials
      --disable-sync
      --disable-translate
      --hide-scrollbars
      --incognito
      --metrics-recording-only
      --mute-audio
      --no-default-browser-check
      --no-first-run
      --safebrowsing-disable-auto-update
      --start-fullscreen
      --window-size=1920,1080
    ]
  end

  context 'when is chrome' do
    let!(:parameters) { { browser: :selenium_chrome } }

    it 'receives the right arguments' do
      expect(subject.arguments).to eq chrome_family_arguments
    end

    context 'when arguments is given' do
      let!(:parameters) { { arguments: ['--custom'], browser: :firefox } }

      it 'is used' do
        expect(subject.arguments).to eq ['--custom']
      end
    end
  end

  context 'when is chrome headless' do
    let!(:parameters) { { browser: :selenium_chrome_headless } }

    it 'receives the right arguments' do
      expect(subject.arguments).to eq chrome_family_arguments
    end

    context 'when arguments is given' do
      let!(:parameters) { { arguments: ['--custom'], browser: :selenium_chrome_headless } }

      it 'is used' do
        expect(subject.arguments).to eq ['--custom']
      end
    end
  end

  context 'when is firefox' do
    let!(:parameters) { { browser: :firefox } }

    it 'receives the right arguments' do
      expect(subject.arguments).to eq []
    end

    context 'when arguments is given' do
      let!(:parameters) { { arguments: ['--custom'], browser: :firefox } }

      it 'is used' do
        expect(subject.arguments).to eq ['--custom']
      end
    end
  end
end
