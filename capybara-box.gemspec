# frozen_string_literal: true

require_relative 'lib/capybara-box/version'

Gem::Specification.new do |spec|
  spec.author           = 'Washington Botelho'
  spec.description      = 'A Tool Box for Capybara.'
  spec.email            = 'wbotelhos@gmail.com'
  spec.extra_rdoc_files = Dir['CHANGELOG.md', 'LICENSE', 'README.md']
  spec.files            = Dir['lib/**/*']
  spec.homepage         = 'https://github.com/wbotelhos/capybara-box'
  spec.license          = 'MIT'
  spec.name             = 'capybara-box'
  spec.platform         = Gem::Platform::RUBY
  spec.summary          = 'A Tool Box for Capybara.'
  spec.version          = CapybaraBox::VERSION

  spec.add_dependency 'capybara-screenshot'
  spec.add_dependency 'capybara'
  spec.add_dependency 'selenium-webdriver'
  spec.add_dependency 'webdrivers'

  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
end
