module Jaimito

  class Config
    class << self
      attr_accessor :model_name, :mailer_name_attribute, :method_name_attribute,
                    :template_subject_attribute, :template_body_attribute,
                    :available_locales, :locale_attribute
    end
  end

end
