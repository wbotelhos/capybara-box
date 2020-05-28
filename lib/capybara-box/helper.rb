# frozen_string_literal: true

module CapybaraBox
  module Helper
    module_function

    def blank?(value)
      [''].include?(value.to_s.strip)
    end

    def present?(value)
      !blank?
    end

    def true?(value)
      ['true', true].include?(value)
    end
  end
end
