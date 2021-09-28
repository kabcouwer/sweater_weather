class User < ApplicationRecord
  before_save { email.downcase! }
  after_save :create_api_key

  has_many :api_keys, as: :bearer

  validates :email, presence: true
  validates :email, format: /@/
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  has_secure_password

  private
  def create_api_key
    self.api_keys.create!(token: SecureRandom.hex)
  end
end
