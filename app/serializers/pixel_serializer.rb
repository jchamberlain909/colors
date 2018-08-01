class PixelSerializer < ActiveModel::Serializer
  attributes :id, :x, :y, :color
end
