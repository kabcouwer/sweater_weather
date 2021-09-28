class User < ApplicationRecord
  # before_save :downcase_email

  has_many :api_keys, as: :bearer 

  validates :email, presence: true
  validates :email, format: /@/
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  has_secure_password

  # private
  # def downcase_email
  #   self.email = self.email.delete(' ').downcase
  # end
end
