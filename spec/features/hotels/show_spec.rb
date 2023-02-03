require 'rails_helper'

  RSpec.describe 'as a user' do
     describe "when the user visits '/hotels/:id'" do 
        it 'displays the individual hotel with all of its attributes' do #user story 2  

     hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
     hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)

     visit "/hotels/#{hotel1.id}"

     expect(page).to have_content(hotel1.name)
     expect(page).to have_content(hotel1.starlink)
     expect(page).to have_content(hotel1.meters_from_beach)
     expect(page).to have_content(hotel1.created_at)
     expect(page).to have_content(hotel1.updated_at)
     expect(hotel1.meters_from_beach).to eq(55)
     expect(hotel1.starlink).to eq(true)
     expect(page).to_not have_content(hotel2.name)
     expect(page).to_not have_content(hotel2.starlink)

      end 
    
    it 'displays the individual hotel with all of its attributes test 2' do #user story 2 

      hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
 
      visit "/hotels/#{hotel2.id}"
 
      expect(page).to have_content(hotel2.name)
      expect(page).to have_content(hotel2.starlink)
      expect(page).to have_content(hotel2.meters_from_beach)
      expect(hotel2.meters_from_beach).to eq(346)
      expect(hotel2.starlink).to eq(false)
      expect(page).to_not have_content(hotel1.name)
      expect(page).to_not have_content(hotel1.starlink)
 
    end 


    it "it displays a link to all of the guests of that hotel" do #user story 10 
      hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)

      visit "/hotels/#{hotel1.id}"
      save_and_open_page

      expect(page).to have_link("Guests staying at Casa Flow", href: "/hotels/#{hotel1.id}/guests")

    end
  end 

end