module Jaimito
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      def install
        template "initializer.rb", "config/initializers/jaimito_initializer.rb"
        template "model.rb", "app/models/mail_template.rb"
        template "mailer.rb", "app/mailers/sample_mailer.rb"
        template "mailer_seed.rb", "db/mailers_seed.rb"
        template "jaimito.yml", "config/locales/jaimito.yml"
        migration_template "migration_create_mail_templates.rb", "db/migrate/create_mail_templates.rb"
      end

      def self.next_migration_number(dirname)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

    end
  end
end
