class PixelSerializer < ActiveModel::Serializer
  attributes :x, :y, :color
  belongs_to :user, serializer: PixelUserSerializer
end
