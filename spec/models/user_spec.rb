require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('email@address.com').for(:email) }
    it { should_not allow_value('foo').for(:email) }

    it { should validate_presence_of(:password) }
  end
end
