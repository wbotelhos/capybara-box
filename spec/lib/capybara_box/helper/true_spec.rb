# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CapybaraBox::Helper, '.true?' do
  it { expect(described_class.true?('')).to      eq false }
  it { expect(described_class.true?('42')).to    eq false }
  it { expect(described_class.true?('false')).to eq false }
  it { expect(described_class.true?('true')).to  eq true }
  it { expect(described_class.true?(42)).to      eq false }
  it { expect(described_class.true?(false)).to   eq false }
  it { expect(described_class.true?(nil)).to     eq false }
  it { expect(described_class.true?(true)).to    eq true }
end
