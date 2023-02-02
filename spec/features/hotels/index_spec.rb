require 'rails_helper'

RSpec.describe 'for each hotel table' do
   describe "as a visitor" do 


    describe "when the user visits '/hotels'" do 
      it 'displays all of the hotels at the index page' do #user story 1 
        require 'pry'; binding.pry
        hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)

        visit '/hotels'

        expect(page).to have_content(hotel1.name)
        expect(page).to have_content(hotel2.name)
        end
      end 
 
    
  describe "when the user visits /hotels" do 
    it "displays the hotels by the time when their records were created in the system and includes a created_by next to each one" do #User Story 6- feature test. STILL NEED TO DO THIS METHOD TEST AND ACTUALLY CREATE THE METHOD 

    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55, created_at: Time.zone.parse("2022-01-01 12:00:00"))
    hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346, created_at: Time.zone.parse("2022-01-02 12:00:00"))
    hotel3 = Hotel.create!(name: "Toucan", starlink:false, meters_from_beach: 375, created_at: Time.zone.parse("2021-01-01 12:00:00"))

    visit "/hotels"
      save_and_open_page
    expect(hotel2.name).to appear_before(hotel1.name)
    expect(hotel1.name).to appear_before(hotel3.name)
    # expect()

  end 
end 
end 
end 
