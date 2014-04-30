namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    user = User.create(name: "Michiel Nuytemans", email: "michiel.nuytemans@gmail.com", password: "13paps", password_confirmation: "13paps")
    user.toggle!(:admin)

    32.times do |n|
      country = Faker::Address.country
      Country.create(name: country)
    end

    5.times do |n|
      y = 5 - n 
      Round.create(name: y.to_s + " th Round", teams: 2**(n) )
    end

    5.times do |n|
      homeside = Faker::Name.name
      awayside = Faker::Name.name
      playdate = Date.tomorrow+n
      group = "A"
      Game.create(homeside: homeside,
                  awayside: awayside,
                  playdate: playdate,
                  group: group)
    end

    5.times do |n|
      homeside = Faker::Name.name
      awayside = Faker::Name.name
      playdate = Date.tomorrow+n
      group = "B"
      Game.create(homeside: homeside,
                  awayside: awayside,
                  playdate: playdate,
                  group: group)
    end

    5.times do |n|
      homeside = Faker::Name.name
      awayside = Faker::Name.name
      playdate = Date.tomorrow+n
      group = "C"
      Game.create(homeside: homeside,
                  awayside: awayside,
                  playdate: playdate,
                  group: group)
    end
  end
end