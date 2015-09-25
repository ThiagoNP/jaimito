class CreateMailTemplates < ActiveRecord::Migration
  create_table :mail_templates do | t |
    t.string :subject
    t.text :body
    t.string :mailer_name
    t.string :method_name
    t.string :locale
  end
end
