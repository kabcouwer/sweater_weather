class UsersSerializer
  def self.new(user)
    {
      data: {
        type: 'users',
        id: user.id.to_s,
        attributes: {
          email: user.email,
          api_key: user.api_keys.first.token
        }
      }
    }
  end
end
