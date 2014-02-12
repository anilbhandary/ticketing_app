require 'date'
namespace :db do
  desc "Fill database with sample event data"
  task populate: :environment do
    populate_events
    populate_users
    populate_user_events
  end
  
  def populate_events
    from = Date.new(2013, 11, 11)
    to   = Date.new(2014, 6, 7)
    
    rand_dates = []
    15.times.each do
      rand_dates << rand(from..to)
    end
    
    rand_dates.each do |rand_date|
      name = Faker::Name.name
      description = Faker::Lorem.sentence(5)
      Event.create!(name: name,
                   description: description,
                   event_date: rand_date)
    end
  end
  
  def populate_users
    admin = User.create!(name:     "Example User",
                         email:    "example@example.com",
                         gender: "Male",
                         password: "foobar",
                         password_confirmation: "foobar")
    19.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password  = "password"
      User.create!(name:     name,
                   email:    email,
                   gender: "Female",
                   password: password,
                   password_confirmation: password)
    end
  end
  
  def populate_user_events
    users = User.all
    user = User.first
    user2 = users[2]
    events = Event.all
    user_events1 = events[1..10]
    user_events2 = events[1..16]
    
    user_events1.each { |event| user.attend!(event) }
    user_events2.each { |event| user2.attend!(event) }
  end
end