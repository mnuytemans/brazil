FactoryGirl.define do
  factory :user do
    name     "Michael Nuytemans"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :game do
  	homeside "Belgium"
  	awayside "Algeria"
  	playdate Date.tomorrow
  	group "A"
  end


end