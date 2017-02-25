source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 4.0']
gem 'facter'
gem 'metadata-json-lint'
gem 'puppet', puppetversion
gem 'puppet-lint'
gem 'puppetlabs_spec_helper'
gem 'rspec-puppet'
gem 'rspec-puppet-facts'
gem 'rubocop'

gem 'puppet-blacksmith', group: :development

gem 'beaker-rspec', group: :system_tests
