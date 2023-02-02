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
    end 
    it 'displays the individual hotel with all of its attributes test 2' do 

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
end