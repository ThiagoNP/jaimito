require 'pry'
require 'pry-byebug'
require 'jaimito'

Dir[File.expand_path('spec/support/**/*.rb'), __FILE__].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    class MailTemplateTest < ActiveRecord::Base; end
    class User < ActiveRecord::Base; end
    class Admin < ActiveRecord::Base; end

    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: ':memory:'
    )

    silence_stream(STDOUT) do
      ActiveRecord::Migration.class_eval do
        create_table :users do |t|
          t.string  :email
          t.text :name
        end

        create_table :admins do |t|
          t.string  :email
          t.text :name
        end

        create_table :mail_template_tests do |t|
          t.string :subject
          t.text   :body
          t.string :mailer_name
          t.string :method_name
          t.string :locale
        end
      end
    end
    ActionMailer::Base.delivery_method = :test
  end
end
