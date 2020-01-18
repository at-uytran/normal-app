require "bcrypt"

class Account < ApplicationRecord
  include WardenFunction
  include BCrypt
  acts_as_paranoid
  attr_accessor :password
  wardenable :database_authenticateable

  validates :name, presence: true
  validates :email, presence: true
  validates :email, format_rule: true
  before_save :encrypt_password
  has_one :user

  def encrypt_password
    return if password.blank?
    self.encrypted_password = Password.create(self.password)
  end
end
