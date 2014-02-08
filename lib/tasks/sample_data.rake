namespace :db do
  desc "Fill database with sample event data"
  task populate: :environment do
    Event.create!(name: "Example Event",
                  description: "Description")
    9.times do |n|
      name  = Faker::Name.name
      description = "Description-#{n+1}"
      Event.create!(name: name,
                   description: description)
    end
  end
end