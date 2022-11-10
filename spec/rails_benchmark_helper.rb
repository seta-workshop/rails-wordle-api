# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'benchmark'
require File.expand_path('../config/environment', __dir__)
abort("RAILS_ENV isnt running in benchmark mode!, add RAILS_ENV=benchmark") unless Rails.env.benchmark?

require 'rspec/rails'
require 'spec_benchmark_helper'
require 'database_cleaner'
require 'capybara/rspec'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
