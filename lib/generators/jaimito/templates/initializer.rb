Jaimito.configure do |config|
  config.model_name = 'mail_template'
  config.template_subject_attribute = 'subject'
  config.template_body_attribute = 'body'
  config.mailer_name_attribute = 'mailer_name'
  config.method_name_attribute = 'method_name'
  config.locale_attribute = 'locale'
  config.available_locales = [ 'en', 'pt-br' ]
end
