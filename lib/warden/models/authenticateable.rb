module Warden
  module Models
    module Authenticateable
      def authenticateable_salt
        account.encrypted_password[0..29] if account.encrypted_password
      end
    end
  end
end
