module WardenFunction
  extend ActiveSupport::Concern

  module ClassMethods
    def wardenable *modules
      modules.each do |mod|
        include Warden::Models.const_get(mod.to_s.classify)
      end
    end
  end
end
