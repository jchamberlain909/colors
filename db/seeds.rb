# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Create a user
User.create(username: 'Player One')

for x in 0..49 do
    for y in 0..49 do
        Pixel.create(color: 'red', x:x, y:y)
    end 
end


