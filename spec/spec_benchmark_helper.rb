# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'benchmark'
require File.expand_path('../config/environment', __dir__)

require 'factory_bot_rails'
require 'rspec-benchmark'

RSpec.configure do |config|
  #Benchmark enabled globally for all specs in the benchmark folder
  config.include RSpec::Benchmark::Matchers

  #De aca para abajo es el calco de spec_helper.rb
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:transaction)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # config.before(:all) do
  #   DatabaseCleaner.start
  # end

  # config.after(:all) do
  #   DatabaseCleaner.clean
  # end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
