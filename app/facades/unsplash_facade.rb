class UnsplashFacade
  def self.picture(location)
    data = UnsplashService.picture(location)
    Image.new(data, location)
  end
end
