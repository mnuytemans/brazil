require 'spec_helper'

describe "User Pages" do
	subject{page}

	it {should have_content('Signup')}
	it {should have_title(full_title('Sign up')) }

	describe "Profile Page" do
		let(:user) {FactoryGirl.create(:user)}
		before {visit user_path(user)}

		it {should have_content(user.name)}
		it {should have_title(user.name)}
	end

	describe "signup" do
		before {visit signup_path}

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect {click_button submit}.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", 	with: "Michiel Nuytemans"
				fill_in "Email",	with: "michiel.nuytemans@gmail.com"
				fill_in "Password", 	with: "foobar"
				fill_in "Confirmation",	with: "foobar"
			end

			it "should create a user" do
				expect {click_button submit}.to change(User, :count).by(1)
			end
		end
	end
end

