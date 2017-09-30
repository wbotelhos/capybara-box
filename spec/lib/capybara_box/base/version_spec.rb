require 'rails_helper'

RSpec.describe CapybaraBox::Base, '.version' do
  subject { described_class.configure parameters }

  context 'when version is given' do
    let!(:parameters) { { version: '2.30' } }

    context 'and browser is chrome' do
      before { parameters[:browser] = :chrome }

      it 'applies the version' do
        expect(subject.version).to eq '2.30'
      end
    end

    context 'and browser is chrome headless' do
      before { parameters[:browser] = :chrome_headless }

      it 'applies the version' do
        expect(subject.version).to eq '2.30'
      end
    end

    context 'and browser is not chrome headless' do
      before { parameters[:browser] = :firefox }

      it 'does not apply the version' do
        expect(subject.version).to be_nil
      end
    end
  end
end
