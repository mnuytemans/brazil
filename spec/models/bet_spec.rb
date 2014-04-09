require 'spec_helper'

describe Bet do
  	let(:user) {FactoryGirl.create(:user)}
	let(:game) {FactoryGirl.create(:game)}

	before do
		@bet = Bet.new(homescore: 3, awayscore: 0, user: user, game: game)
	end

	subject{@bet}

	it {should respond_to(:game)}
	it {should respond_to(:user)}
	it {should respond_to(:homescore)}
	it {should respond_to(:awayscore)}

	it {should be_valid}

	describe "It should be invalid" do
		describe "when game is absent" do
			before {@bet.game = nil}
			it {should_not be_valid}
		end

		describe "when user is absent" do
			before {@bet.user =nil} 
			it {should_not be_valid}
		end

		describe "when homescore is absent" do
			before {@bet.homescore = nil}
			it {should_not be_valid}
		end

		describe "when awayscore is absent" do
			before {@bet.awayscore = nil}
			it {should_not be_valid}
		end
	end



end
