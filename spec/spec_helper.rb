ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'faker'

Dir["#{::Rails.root}/spec/support/**/*.rb"].each{ |file| load "#{file}" }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
end
