require 'rails_helper'

RSpec.describe Image, :vcr do
  before :each do
    @location = 'denver,co'
    @data = UnsplashService.picture(@location)
    @image = Image.new(@data, @location)
  end

  it 'can make an image poro' do
    expect(@image).to be_an(Image)
    expect(@image.location).to eq(@location)
    expect(@image.image_url).to be_a(String)
    expect(@image.source).to eq('unsplash.com')
    expect(@image.author).to be_a(String)
    expect(@image.profile).to be_a(String)
  end
end
