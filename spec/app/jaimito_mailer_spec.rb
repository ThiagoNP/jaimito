require 'spec_helper'

describe Jaimito::Mailer do
  before(:all) do
    class TestMailer < ActionMailer::Base
      include Jaimito::Mailer
      default from: "a@a.com"
      get_receiver_email_from user: :email
    end
  end
  before(:each) { ActionMailer::Base.deliveries.clear }

  it 'sends a email' do
    Jaimito.configure do |config|
      config.model_name = 'mail_template_test'
      config.locale_attribute = 'locale'
      config.template_subject_attribute = 'subject'
      config.template_body_attribute = 'body'
      config.mailer_name_attribute = 'mailer_name'
      config.method_name_attribute = 'method_name'
      config.available_locales = [ 'en', 'pt-br' ]
    end
    user = User.create(email: 'user@user.com', name: 'jaimito')

    MailTemplateTest.create!(
      subject: 'Welcome [[User - Name]]!',
      body: %Q(<b>Welcome [[User - Name]]</b> to our platform!),
      mailer_name: 'test_mailer',
      method_name: 'sample_mail',
      locale: :en
    )

    TestMailer.sample_mail(user).deliver
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'changes const name' do
    TranslationsCreater.create_classes_name("user", "user")
    TranslationsCreater.create_attributes_name("user", "name", "name")

    Jaimito.configure do |config|
      config.model_name = 'mail_template_test'
      config.locale_attribute = 'locale'
      config.template_subject_attribute = 'subject'
      config.template_body_attribute = 'body'
      config.mailer_name_attribute = 'mailer_name'
      config.method_name_attribute = 'method_name'
      config.available_locales = [ 'en', 'pt-br' ]
    end
    user = User.create(email: 'user@user.com', name: 'jaimito')

    MailTemplateTest.create!(
      subject: 'Welcome [[User - Name]]!',
      body: %Q(<b>Welcome [[User - Name]]</b> to our platform!),
      mailer_name: 'test_mailer',
      method_name: 'sample_mail',
      locale: :en
    )

    mailer = TestMailer.sample_mail(user)
    expect(mailer.subject.include?(user.name)).to be true
  end

  it 'changes const name from both classes' do
    TranslationsCreater.create_classes_name("user", "user")
    TranslationsCreater.create_classes_name("admin", "admin")
    TranslationsCreater.create_attributes_name("user", "name", "name")
    TranslationsCreater.create_attributes_name("admin", "name", "name")

    Jaimito.configure do |config|
      config.model_name = 'mail_template_test'
      config.locale_attribute = 'locale'
      config.template_subject_attribute = 'subject'
      config.template_body_attribute = 'body'
      config.mailer_name_attribute = 'mailer_name'
      config.method_name_attribute = 'method_name'
      config.available_locales = [ 'en', 'pt-br' ]
    end
    user = User.create(email: 'user@user.com', name: 'jaimito')
    admin = Admin.create(email: 'admin@admin.com', name: 'admin')

    MailTemplateTest.create!(
      subject: '[[User - Name]] want to subscribe!',
      body: %Q(<b>[[Admin - Name]]</b> [[User - Name]] want to subscribe!),
      mailer_name: 'test_mailer',
      method_name: 'admin_mail',
      locale: :en
    )

    mailer = TestMailer.admin_mail(user, admin)
    expect(mailer.subject.include?(user.name)).to be true
    expect(mailer.body.raw_source.include?(admin.name)).to be true
  end
end
