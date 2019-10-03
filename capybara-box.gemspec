# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capybara-box/version'

Gem::Specification.new do |spec|
  spec.author      = 'Washington Botelho'
  spec.description = 'A Tool Box for Capybara.'
  spec.email       = 'wbotelhos@gmail.com'
  spec.files       = Dir['lib/**/*'] + %w[CHANGELOG.md LICENSE README.md]
  spec.homepage    = 'https://github.com/wbotelhos/capybara-box'
  spec.license     = 'MIT'
  spec.name        = 'capybara-box'
  spec.platform    = Gem::Platform::RUBY
  spec.summary     = 'A Tool Box for Capybara.'
  spec.test_files  = Dir['spec/**/*']
  spec.version     = CapybaraBox::VERSION

  spec.add_dependency 'capybara-screenshot'
  spec.add_dependency 'capybara'
  spec.add_dependency 'selenium-webdriver'

  spec.add_development_dependency 'chromedriver-helper'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
end
