require 'faker'

# Create Apps
20.times do
  App.create!(
    user_id: 1,
    title:  Faker::Lorem.sentence,
    url:   Faker::Internet.url
  )
end

admin = User.new(
  name: "Eric Park",
  email: "erichoonpark@gmail.com",
  password: "bullseye",
)

admin.skip_confirmation!
admin.save!

puts "Seed finished"
puts "#{admin.name} created"
puts "#{App.count} apps created"
