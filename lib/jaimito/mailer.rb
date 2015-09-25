module Jaimito
  module Mailer
    extend ActiveSupport::Concern

    included do
      @jaimito_mailer_config = {}

      def self.get_receiver_email_from(model_with_attribute)
        @jaimito_mailer_config[:model_to_get_receiver_email] =
          model_with_attribute.keys.first.to_s.downcase
        @jaimito_mailer_config[:attribute_to_get_receiver_email] =
          model_with_attribute.values.first.to_s
      end

      def self.model_to_get_receiver_email
        @jaimito_mailer_config[:model_to_get_receiver_email]
      end

      def self.attribute_to_get_receiver_email
        @jaimito_mailer_config[:attribute_to_get_receiver_email]
      end

      def self.method_missing(method, *args, &block)
        if Jaimito::MailTemplate.exists?(self, method)
          define_mailer_method(method)
          return self.send(method, *args)
        end
        super
      end

      private

      def self.define_mailer_method(method)
        define_method method do | *args |
          mail(
            to: self.class.get_receiver_email(*args),
            subject: Jaimito::MailTemplate.subject(self.class, method, *args),
            body: Jaimito::MailTemplate.body(self.class, method, *args)
          )
        end

        define_singleton_method method do | *args |
          self.send(:new).send(method, *args)
        end
      end

      def self.get_receiver_email(*args)
        args.each do | arg |
          if arg.class.name.downcase == self.model_to_get_receiver_email
            return arg.send(self.attribute_to_get_receiver_email)
          end
        end
      end

    end
  end
end
