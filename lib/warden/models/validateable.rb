module Warden
  module Models
    module Validateable
      extend ActiveSupport::Concern
      included do
        attr_accessor :skip_password_validation, :password

        validate_presence_of :password, unless: :skip_password_validation
        validate :password_rule
      end

      def password_rule
        return if self.password.blank? || self.password.match?(Settings.regexp.password)
        errors.add(:password, :invalid)
      end
    end
  end
end
