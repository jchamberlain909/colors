class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :totalPixels
  has_many :pixels
end
