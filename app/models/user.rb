class User < ApplicationRecord
  validates :email, presence: true
  validates :email, format: /@/
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  has_secure_password
end
