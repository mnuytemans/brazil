namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Create the rounds 
      Round.create(name: "16de Finale", teams: 16)
      Round.create(name: "Kwartfinale", teams: 8)
      Round.create(name: "Halve Finale", teams: 4)
      Round.create(name: "Finale", teams: 2)
      Round.create(name: "Wereldkampioen", teams: 1)

    # Create the teams
      uri = URI.parse("http://footballdb.herokuapp.com/api/v1/event/world.2014/teams/")

      response = Net::HTTP.get_response(uri)

      json_response = JSON.parse response.body

      for i in 0..json_response["teams"].count - 1
        Country.create(name: json_response["teams"][i]["title"])
      end


    # Create the rounds
      for i in 1..15
        uri_string = "http://footballdb.herokuapp.com/api/v1/event/world.2014/round/" + i.to_s

        uri = URI.parse(uri_string)

        response = Net::HTTP.get_response(uri)

        json_response = JSON.parse response.body

        for i in 0..json_response["games"].count - 1
          Game.create(homeside: json_response["games"][i]["team1_title"] , awayside: json_response["games"][i]["team2_title"], 
            playdate: json_response["games"][i]["play_at"], group: "A" )
        end
      end


    # Create the setting parameters needs to run the application
      Setting.create(name: "Status", value: 0)
      Setting.create(name: "16de Finale", value: 0)
      Setting.create(name: "8ste Finale", value: 0)
      Setting.create(name: "Kwartfinale", value: 0)
      Setting.create(name: "Halve Finale", value: 0)
      Setting.create(name: "Wereldkampioen", value: 0)
      Setting.create(name: "Exact Score", value: 0)
      Setting.create(name: "Correct Score", value: 0)
      Setting.create(name: "Incorrect Score", value: 0)

  end
end