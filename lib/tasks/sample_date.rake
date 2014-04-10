namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    5.times do |n|
      homeside = Faker::Name.name
      awayside = Faker::Name.name
      homescore = Faker::Number.number(1) 
      awayscore = Faker::Number.number(1)
      playdate = Date.tomorrow+n
      group = "A"
      Game.create(homeside: homeside,
                  awayside: awayside,
                  homescore: homescore,
                  awayscore: awayscore,
                  playdate: playdate,
                  group: group)
    end

    5.times do |n|
      homeside = Faker::Name.name
      awayside = Faker::Name.name
      homescore = Faker::Number.number(1) 
      awayscore = Faker::Number.number(1)
      playdate = Date.tomorrow+n
      group = "B"
      Game.create(homeside: homeside,
                  awayside: awayside,
                  homescore: homescore,
                  awayscore: awayscore,
                  playdate: playdate,
                  group: group)
    end

    5.times do |n|
      homeside = Faker::Name.name
      awayside = Faker::Name.name
      homescore = Faker::Number.number(1) 
      awayscore = Faker::Number.number(1)
      playdate = Date.tomorrow+n
      group = "C"
      Game.create(homeside: homeside,
                  awayside: awayside,
                  homescore: homescore,
                  awayscore: awayscore,
                  playdate: playdate,
                  group: group)
    end
  end
end