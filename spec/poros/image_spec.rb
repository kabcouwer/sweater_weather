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

  it 'can serialize' do
    expect(@image.serialize).to be_a(Hash)
    expect(@image.serialize).to have_key(:image)
    expect(@image.serialize[:image]).to be_a(Hash)

    expect(@image.serialize[:image]).to have_key(:location)
    expect(@image.serialize[:image][:location]).to be_a(String)

    expect(@image.serialize[:image]).to have_key(:image_url)
    expect(@image.serialize[:image][:image_url]).to be_a(String)

    expect(@image.serialize[:image]).to have_key(:credit)
    expect(@image.serialize[:image][:credit]).to be_a(Hash)

    expect(@image.serialize[:image][:credit]).to have_key(:source)
    expect(@image.serialize[:image][:credit][:source]).to be_a(String)

    expect(@image.serialize[:image][:credit]).to have_key(:author)
    expect(@image.serialize[:image][:credit][:author]).to be_a(String)

    expect(@image.serialize[:image][:credit]).to have_key(:profile)
    expect(@image.serialize[:image][:credit][:profile]).to be_a(String)
  end
end
