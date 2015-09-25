require 'rubygems'
require 'active_support'
require 'action_mailer'
require 'sanitize'
require 'active_record'
require 'jaimito/version'
require 'jaimito/errors'
require 'jaimito/config'
require 'jaimito/mail_template'
require 'jaimito/mailer'

module Jaimito
  def self.configure
    yield Config
  end
end
