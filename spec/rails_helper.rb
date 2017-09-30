# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'capybara'
require 'capybara-box'
require 'pry-byebug'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |file| require file }
