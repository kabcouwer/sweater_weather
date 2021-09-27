class UnsplashFacade
  def picture(location)
    data = UnsplashService.picture(location)
    Image.new(data)
  end
end
