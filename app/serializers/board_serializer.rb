class BoardSerializer < ActiveModel::Serializer
  attributes :id, :game_type
  has_many :pixels
  has_many :users
end
