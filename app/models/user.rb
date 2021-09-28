class User < ApplicationRecord
  before_save { email.downcase! }
  after_save :create_api_key

  has_many :api_keys, as: :bearer

  validates :email, presence: true
  validates :email, format: /@/
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  has_secure_password

  def self.get_user_by_key(api_key)
    select('users.*')
    .joins(:api_keys)
    .where('api_keys.token = ?', api_key)
    .first
  end

  private
  def create_api_key
    self.api_keys.create!(token: SecureRandom.hex)
  end
end
