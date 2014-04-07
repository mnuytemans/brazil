require 'spec_helper'

describe "Static Pages" do 
	describe "Home Page" do 
		it "should have the content 'Brazil'" do
			visit root_path
			expect(page).to have_content('Brazil')
		end

		it "should have the right title" do
			visit root_path
			expect(page).to have_title('Brazil | Home')
		end

	end
	describe "Help Page" do 
		it "should have the content 'Help'" do 
			visit help_path
			expect(page).to have_content('Help')
		end

		it "should have the right title" do
			visit help_path
			expect(page).to have_title('Brazil | Help')
		end
	end

	describe "About Page" do
		it "should have the content 'About Us'" do 
			visit about_path
			expect(page).to have_content('About Us')
		end
		it "should have the right title" do
			visit about_path
			expect(page).to have_title('Brazil | About')
		end
	end

	describe "Contact Page" do

		it "should have the content 'Contact'" do
			visit contact_path
			expect(page).to have_content('Contact')
		end

		it "should have the title 'Contact'" do
			visit contact_path
			expect(page).to have_title('Brazil | Contact')
		end
	end

end
