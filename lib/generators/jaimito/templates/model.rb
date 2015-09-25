class MailTemplate < ActiveRecord::Base
  validates :subject, presence: true
  validates :body, presence: true
  validates :mailer_name, presence: true
  validates :method_name, presence: true,
            uniqueness: { scope: [:locale, :mailer_name]}
  validates :locale, presence: true,
                     inclusion: { in: Jaimito::Config.available_locales }

  validate :mailer_class_should_exist

  private

  def mailer_class_should_exist
    mailer_name.classify.constantize
  rescue
    errors.add(:mailer_name, :invalid)
  end
end
