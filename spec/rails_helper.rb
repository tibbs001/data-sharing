require 'helpers/form_helpers.rb'
ENV["RACK_ENV"] = "test"
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
abort("AACT_ADMIN_DATABASE_URL environment variable is set")   if !ENV["AACT_ADMIN_DATABASE_URL"]
abort("AACT_BACK_DATABASE_URL environment variable is set")    if !ENV["AACT_BACK_DATABASE_URL"]
abort("AACT_PUBLIC_DATABASE_URL environment variable is set")  if !ENV["AACT_PUBLIC_DATABASE_URL"]
abort("AACT_PUBLIC_HOSTNAME environment variable is set")      if !ENV["AACT_PUBLIC_HOSTNAME"]
abort("AACT_PUBLIC_DATABASE_NAME environment variable is set") if !ENV["AACT_PUBLIC_DATABASE_NAME"]
abort("AACT_DB_SUPER_USERNAME environment variable is set")    if !ENV["AACT_DB_SUPER_USERNAME"]

require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
  include Formulaic::Dsl
end

RSpec.configure do |config|
  config.include Features, type: :feature
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.include FormHelpers, :type => :feature
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner[:active_record, { model: UserEvent }].clean_with(:truncation)
    DatabaseCleaner[:active_record, { model: Public::Study }].clean_with(:truncation)
  end

  config.before(:each) do |example|
    unit_test = ![:feature, :request].include?(example.metadata[:type])
    strategy = unit_test ? :transaction : :truncation

    DatabaseCleaner.strategy = strategy
    DatabaseCleaner[:active_record, { model: UserEvent }].strategy = strategy

    DatabaseCleaner.start
    DatabaseCleaner[:active_record, { model: UserEvent }].start

    # ensure app user logged into db connections
    Public::PublicBase.establish_connection(
      adapter: 'postgresql',
      encoding: 'utf8',
      hostname: ENV['AACT_PUBLIC_HOSTNAME'],
      database: ENV['AACT_PUBLIC_DATABASE_NAME'],
      username: ENV['AACT_DB_SUPER_USERNAME'])
    @dbconfig = YAML.load(File.read('config/database.yml'))
    ActiveRecord::Base.establish_connection @dbconfig[:test]
  end

  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner[:active_record, { model: UserEvent }].clean
    DatabaseCleaner[:active_record, { model: Public::Study }].clean
  end

end

ActiveRecord::Migration.maintain_test_schema!
