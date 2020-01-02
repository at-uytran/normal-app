module Warden
  module Models
    module DatabaseAuthenticateable
      include BCrypt
      attr_accessor :current_password, :password_confirmation

      def valid_password? password
        return false if self.encrypted_password.blank?
        Password.new(self.encrypted_password) == password
      end
    end
  end
end
