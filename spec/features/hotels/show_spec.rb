require 'rails_helper'

  RSpec.describe 'as a user' do
    
    before(:each) do 
      @hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      @hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
    end 
  
      describe "when visiting the hotel's show page" do 

       it "displays the count of the number of guests associated with that parent" do 
 
        visit "/hotels/#{@hotel1.id}"
  
        expect(page).to have_content("Losodeli has 2 guests.")

       end 
 
      it 'displays the individual hotel with all of its attributes' do 

        visit "/hotels/#{@hotel1.id}"

        expect(page).to have_content(@hotel1.name)
        expect(page).to have_content(@hotel1.starlink)
        expect(page).to have_content(@hotel1.meters_from_beach)
        expect(page).to have_content(@hotel1.created_at)
        expect(page).to have_content(@hotel1.updated_at)
        expect(@hotel1.meters_from_beach).to eq(346)
        expect(@hotel1.starlink).to eq(false)
        expect(page).to_not have_content(@hotel2.name)
        expect(page).to_not have_content(@hotel2.starlink)

      end 
    
      it 'displays the individual hotel with all of its attributes test 2' do 

        visit "/hotels/#{@hotel2.id}"
  
        expect(page).to have_content(@hotel2.name)
        expect(page).to have_content(@hotel2.starlink)
        expect(page).to have_content(@hotel2.meters_from_beach)
        expect(@hotel2.meters_from_beach).to eq(55)
        expect(@hotel2.starlink).to eq(true)
        expect(page).to_not have_content(@hotel1.name)
        expect(page).to_not have_content(@hotel1.starlink)
  
      end 

      it "it displays a link to the hotel-guests page" do 

        visit "/hotels/#{@hotel1.id}"

        expect(page).to have_link("Guests staying at Losodeli", href: "/hotels/#{@hotel1.id}/guests")

      end

      it "shows a link to update the hotel 'Update Hotel'" do 
        
        visit "/hotels/#{@hotel1.id}"
        
        page.should have_link("Update Hotel", href: "/hotels/#{@hotel1.id}/edit")
      end

      it "on the individual hotel show page it shows a link to delete the hotel" do 

        visit "/hotels/#{@hotel1.id}"
        
        expect(page).to have_link("Delete Hotel", href: "/hotels/#{@hotel1.id}")

      end

  end 
end 