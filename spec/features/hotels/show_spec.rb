require 'rails_helper'

  RSpec.describe 'as a user' do

    describe "as a visitor" do #user story 7 
      describe "when visiting the hotel's show page" do 
       it "displays the count of the number of guests associated with that parent" do 
 
       hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
       guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
       guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
       hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
       guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
 
       visit "/hotels/#{hotel1.id}"
 
       expect(page).to have_content("Losodeli has 2 guests.")
 
      end
     end 
   end 
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
          

          expect(page).to have_link("Guests staying at Casa Flow", href: "/hotels/#{hotel1.id}/guests")

        end
# User Story 12
        it "shows a link to update the hotel 'Update Hotel'" do 

          hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
          
          visit "/hotels/#{hotel1.id}"
          
          page.should have_link("Update Hotel", href: "/hotels/#{hotel1.id}/edit")
        end

        it "clicking the link takes to a page '/hotels/:id/edit' where there is a form to update the hotel's attributes" do 

          hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
          
          visit "/hotels/#{hotel1.id}"

          click_link "Update Hotel"

          expect(page).to have_current_path("/hotels/#{hotel1.id}/edit")
          expect(page).to have_selector("form")
          expect(page).to have_content("Update Hotel Name")
          expect(page).to have_content("Update Hotel Starlink Status")
          expect(page).to have_content("Update Hotel Meters from Beach")
          
        end
      end #when user visits hotels/:id --> hotels#show

      describe "when the user fills out the form with updated info and click the submit button" do 
        it "we are redirected to the individual hotel's show page and the hotel's info has been updated" do 

          hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)

          visit "/hotels/#{hotel1.id}/edit"

          fill_in "hotel[name]", with: "Diego's House"
          fill_in "hotel[meters]", with: 355

          click_button("Update Hotel")
          
          expect(page).to have_current_path("/hotels/#{hotel1.id}")
          expect(page).to have_content("Diego's House")
          expect(page).to have_content("false")
          expect(page).to_not have_content("true")
          
        end

        it "we are redirected to the individual hotel's show page and the hotel's info has been updated- test 2 with Starlink checked yes" do 

          hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)

          visit "/hotels/#{hotel1.id}/edit"

          fill_in "hotel[name]", with: "Diego's House"
          check "Starlink"
          fill_in "hotel[meters]", with: 355

          click_button("Update Hotel")
          
          expect(page).to have_current_path("/hotels/#{hotel1.id}")
          expect(page).to have_content("Diego's House")
          expect(page).to have_content("true")
          expect(page).to_not have_content("false")
          
        end
      end # when fills out the form with updated info and click the submit button"

      describe "deleting the hotel" do 
      before(:each)do 
        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
        @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
        @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
        @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
        @guest4 = @hotel2.guests.create!(name: "Michele", price_per_night_pesos: 500, spanish_speaker: true)
        @guest5 = @hotel2.guests.create!(name: "Radim", price_per_night_pesos: 400, spanish_speaker: false)
        @guest6 = @hotel2.guests.create!(name: "Kain", price_per_night_pesos: 300, spanish_speaker: true)
        @guest7 = @hotel1.guests.create!(name: "Farhad", price_per_night_pesos: 100, spanish_speaker: false)
        @guest8 = @hotel1.guests.create!(name: "Radim", price_per_night_pesos: 200, spanish_speaker: true)
      end

      it "on the individual hotel show page it shows a link to delete the hotel" do 

        visit "/hotels/#{@hotel1.id}"
        
        expect(page).to have_link("Delete Hotel", href: "/hotels/#{@hotel1.id}")

      end

      it "once you click the link of 'Delete Hotel', the parent and its children are deleted and you are returned to the parent index page" do 

        visit "/hotels"


        visit "/hotels/#{@hotel1.id}"

        click_link "Delete Hotel"

        expect(page).to have_current_path("/hotels")
        expect(page).to_not have_content(@hotel1.name)
        expect(page).to have_content(@hotel2.name)
      end



    end #deleting the hotel 
end #as a user