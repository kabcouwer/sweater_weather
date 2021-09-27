class BackgroundSerializer
  def self.background(image)
    {
      data: {
        type: 'image',
        id: nil,
        attributes: image.serialize
      }
    }
  end
end
