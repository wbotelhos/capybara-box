# frozen_string_literal: true

module CapybaraBox
  module Helper
    module_function

    def true?(value)
      ['true', true].include?(value)
    end
  end
end
