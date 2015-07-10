require 'faker'

# Create Apps
45.times do
  App.create!(
    user_id: 1,
    title:  Faker::Lorem.sentence,
    url:   Faker::Internet.url
  )
end

50.times do
  Event.create!(
    name: Faker::Lorem.sentence,
    app_id: Faker::Number.between(1, 45)
)
end


admin = User.new(
  name: "Eric Park",
  email: "erichoonpark@gmail.com",
  password: "bullseye"
)
admin.skip_confirmation!
admin.save!

puts "Seed finished"
puts "#{admin.name} created"
puts "#{App.count} apps created"
puts "#{Event.count} events created"
