require 'rails_helper'

RSpec.describe "the individual hotel's page" do
   describe "as a visitor" do #user story 7 
     describe "when visiting the hotel's show page" do 
      it "displays the count of the number of guests associated with that parent" do 

      hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

      visit "/individual_hotel/#{hotel1.id}"

      expect(page).to have_content("Losodeli has 2 guests.")

     end
    end 
  end 
end 