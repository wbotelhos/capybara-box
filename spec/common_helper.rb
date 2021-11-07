# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'support/coverage'

require 'capybara'
require 'capybara-box'
require 'pry-byebug'

require 'support/common'
