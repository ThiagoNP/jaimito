module Jaimito
  class MailTemplate

    def self.exists?(mailer_class, method)
      model_to_fetch_template.find_by(
        config.mailer_name_attribute => mailer_class.name.underscore,
        config.method_name_attribute => method.to_s)
        .present?
    end

    def self.subject(mailer_class, method, *args)
      template_string = template(mailer_class, method).send(config.template_subject_attribute)
      parse_template_string(template_string, *args)
    end

    def self.body(mailer_class, method, *args)
      template_string = template(mailer_class, method).send(config.template_body_attribute)
      parse_template_string(template_string, *args)
    end

    def self.parse_template_string(template_string, *args)
      args.each do |arg|
        class_name = arg.class.name.underscore
        translated_class_name = I18n.t("jaimito.translated_classes_names.#{class_name}")
        attributes_hash = hash_of_attributes_and_translations(arg.class, class_name)
        attributes_hash.each do |key, value|
          template_string.gsub!(/\[\[\s?#{translated_class_name}\s?-\s?#{value}\s?\]\]/i,
                                arg.send(key))
        end
      end
      Sanitize.fragment(template_string, Sanitize::Config::RELAXED).html_safe
    end

    def self.hash_of_attributes_and_translations(klass, class_name)
      attributes_hash = {}
      klass.attribute_names.each do |attr|
        attributes_hash[attr.to_sym] = attr if I18n.exists?( "jaimito.translated_attributes_names.#{class_name}.#{attr}")
      end
      attributes_hash
    end

    def self.template(mailer_class, method)
      model_to_fetch_template.find_by!(
        config.mailer_name_attribute => mailer_class.name.underscore,
        config.method_name_attribute => method.to_s,
        config.locale_attribute => current_locale
      )
    rescue => e
      raise Jaimito::Errors::InexistentMailerTemplate, %Q(
        The #{config.model_name} #{method} template does not exist!
      )
    end

    def self.model_to_fetch_template
      config.model_name.classify.constantize
    end

    def self.config
      Jaimito::Config
    end

    def self.current_locale
      I18n.locale.to_s
    end

    private_class_method :parse_template_string
    private_class_method :template
    private_class_method :model_to_fetch_template
    private_class_method :hash_of_attributes_and_translations
    private_class_method :config
    private_class_method :current_locale
  end
end
