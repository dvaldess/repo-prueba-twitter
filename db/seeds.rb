# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.create([{
     username: "Diego",
     avatar: Faker::Avatar.image,
     email: "dvaldes@test.cl",
     password: "123456",
     password_confirmation: "123456"
},{
     username: "Isidora",
     avatar: Faker::Avatar.image,
     email: "isidora@test.cl",
     password: "123456",
     password_confirmation: "123456"
},{
    username: "Valeria",
    avatar: Faker::Avatar.image,
    email: "valeria@test.cl",
    password: "123456",
    password_confirmation: "123456"
}])

10.times do
     Tweet.create(
         content: Faker::TvShows::Simpsons.quote,
         user_id: 1
     )
end

10.times do
    Tweet.create(
        content: Faker::TvShows::Simpsons.quote,
        user_id: 2
    )
end


30.times do
    Tweet.create(
         content: Faker::TvShows::Simpsons.quote,
         user_id: Random.rand(1..3)
     )
end
AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?