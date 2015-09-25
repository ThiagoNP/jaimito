class SampleMailer < ActionMailer::Base
  include Jaimito::Mailer
  default from: "jaimito@example.com"
  get_receiver_email_from user: :email
end
