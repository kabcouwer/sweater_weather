require 'rails_helper'

RSpec.describe 'user registration' do
  before :each do
    @user_params = {
      email: Faker::Internet.email,
      password: 'newpassword',
      password_confirmation: 'newpassword'
    }.to_json
    @headers = { 'CONTENT_TYPE' => 'application/json' }
  end

  it 'can register a new user' do
    post '/api/v1/users', headers: @headers, params: @user_params

    new_user = User.last

    expect(response.status).to eq(201)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result).to have_key(:data)

    expect(result[:data]).to be_a(Hash)
    expect(result[:data]).to have_key(:type)
    expect(result[:data][:type]).to eq('users')

    expect(result[:data]).to have_key(:id)
    expect(result[:data][:id]).to be_a(String)

    expect(result[:data]).to have_key(:attributes)
    expect(result[:data][:attributes]).to be_a(Hash)

    expect(result[:data][:attributes]).to have_key(:email)
    expect(result[:data][:attributes][:email]).to be_a(String)

    expect(result[:data][:attributes]).to have_key(:api_key)
    expect(result[:data][:attributes][:api_key]).to be_a(String)
  end
end
