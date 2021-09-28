require 'rails_helper'

RSpec.describe 'user registration' do
  before :each do
    # corrent input
    @user_params_1 = {
      email: Faker::Internet.email,
      password: 'newpassword',
      password_confirmation: 'newpassword'
    }.to_json

    # incorrect input - passwords not matching
    @user_params_2 = {
      email: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'PaSsWorD'
    }.to_json

    # incorrect input - email not given
    @user_params_3 = {
      email: '',
      password: 'password',
      password_confirmation: 'password'
    }.to_json

    # incorrect input - not json
    @user_params_4 = {
      email: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'password'
    }

    @headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end

  describe 'happy paths' do
    it 'can register a new user' do
      expect { post '/api/v1/users', headers: @headers, params: @user_params_1 }.to change(User, :count).by(+1)

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

  describe 'sad paths' do
    it 'returns error if password and password_confirmation do not match' do
      expect { post '/api/v1/users', headers: @headers, params: @user_params_2 }.to change(User, :count).by(0)

      expect(response.status).to eq(422)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq('Please send email and matching password and password_confirmation')
    end

    it 'returns error if email is not given' do
      expect { post '/api/v1/users', headers: @headers, params: @user_params_3 }.to change(User, :count).by(0)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to eq(["Email can't be blank", 'Email is invalid'])
    end

    it 'returns error if invalid json payload' do
      expect { post '/api/v1/users', params: @user_params_1 }.to change(User, :count).by(0)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq('Json content type required')
    end

    xit 'returns error if header not set to application/json' do
      expect { post '/api/v1/users', headers: @headers, params: @user_params_4 }.to change(User, :count).by(0)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to eq('Request body parse error')
    end
  end
end
