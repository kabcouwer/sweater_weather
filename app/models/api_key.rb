class ApiKey < ApplicationRecord
  validates :bearer_id, presence: true
  validates :bearer_type, presence: true
  validates :token, presence: true
  validates :token, uniqueness: true


  belongs_to :bearer, polymorphic: true
end
