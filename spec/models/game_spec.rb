require 'spec_helper'

describe Game do
  before do 
  	@game = Game.new(homeside: "Belgium", awayside: "Brazil", playdate: Date.today-1, group:"Final")
  end

  subject {@game}

	  it {should respond_to(:homeside)}
	  it {should respond_to(:awayside)}
	  it {should respond_to(:playdate)}
	  it {should respond_to(:group)}

	describe "When Homeside is not present" do
	  before {@game.homeside = ""}
	  it {should_not be_valid}
	end
end

