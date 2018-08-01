class Board < ApplicationRecord
    has_many :pixels
    has_many :users
end
