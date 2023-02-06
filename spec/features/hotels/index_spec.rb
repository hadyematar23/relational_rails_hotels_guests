require 'rails_helper'

RSpec.describe 'for each hotel table' do
   describe "as a visitor" do 
    describe "when the user visits '/hotels'" do 

      before :each do 
        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55, created_at: Time.zone.parse("2022-01-01 12:00:00"))
        @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346, created_at: Time.zone.parse("2023-01-02 12:00:00"))
        @hotel3 = Hotel.create!(name: "Toucan", starlink:false, meters_from_beach: 375, created_at: Time.zone.parse("2021-01-01 12:00:00"))
      end

      it 'displays all of the hotels at the index page' do 
        
        hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)

        visit '/hotels'

        expect(page).to have_content(hotel1.name)
        expect(page).to have_content(hotel2.name)

      end 
 
      it "displays the hotels by the time when their records were created in the system " do 

        visit "/hotels"
          
        expect(@hotel2.name).to appear_before(@hotel1.name)
        expect(@hotel1.name).to appear_before(@hotel3.name)
      end 

      it "the visit sees the link to create a new hotel page" do 

        visit "/hotels"
        expect(page).to have_link('Add New Hotel', href: "/hotels/new")

      end

      it "next to every hotel there is a link to edit the parent's information " do 

        visit "/hotels"
        
        expect(page).to have_link("Edit #{@hotel1.name}'s Information", href: "/hotels/#{@hotel1.id}/edit")
      end
      
      it "next to every parent there is a link to delete the parent" do 

        visit "/hotels"
        expect(page).to have_link("Delete #{@hotel1.name}", href: "/hotels/#{@hotel1.id}")
        expect(page).to have_link("Delete #{@hotel2.name}", href: "/hotels/#{@hotel2.id}")

      end
    end

    describe "Extensions" do 
      before(:each) do 

        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        @hotel3 = Hotel.create!(name: "Toucan", starlink: false, meters_from_beach: 450) 
        @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
        @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
        @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
        @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
        @guest4 = @hotel2.guests.create!(name: "Michele", price_per_night_pesos: 500, spanish_speaker: true)
        @guest5 = @hotel2.guests.create!(name: "Radim", price_per_night_pesos: 400, spanish_speaker: false)
        @guest6 = @hotel2.guests.create!(name: "Cayne", price_per_night_pesos: 300, spanish_speaker: true)
        @guest7 = @hotel1.guests.create!(name: "Farhad", price_per_night_pesos: 100, spanish_speaker: false)
        @guest8 = @hotel1.guests.create!(name: "Radim", price_per_night_pesos: 200, spanish_speaker: true)
        @guest9 = @hotel1.guests.create!(name: "Caroline", price_per_night_pesos: 800, spanish_speaker: false)

      end

      describe "Extension1: it sorts parents by the number of children" do 

        it "there is a link to sort hotels by the number of children they have" do 
          visit "/hotels"
          expect(page).to have_link("Sort by number of guests", href: "/hotels/?sort=true")
        end

        it "once you click on the link, it sorts the hotels on the parent index page and lists the count next to each hotel" do 

          visit "/hotels"
          click_link "Sort by number of guests"
          expect(page).to have_current_path("/hotels/?sort=true")
          expect(page).to have_content("Casa Flow: 5 Guests")
          expect(page).to have_content("Losodeli: 4 Guests")
          expect(page).to have_content("Toucan: 0 Guests")
          expect(@hotel1.name).to appear_before(@hotel2.name)
          expect(@hotel2.name).to appear_before(@hotel3.name)

        end
      end 

      describe "extension 2+3: searching by name exact and partial match" do 
        it "when you got to the index page there is a text box that will filter results by keyword" do 

          visit "/hotels"

          expect(page).to have_selector("form")
          expect(page).to have_content("Search for Hotel")
          expect(page).to have_button("Search")

        end

        it "when you have an exact match of one of the records, it will return a page with only the record that you searched for" do 

          visit "/hotels"
          fill_in "searchtext", with: "Losodeli"
          click_button "Search"

          expect(page).to have_current_path("/hotels?searchtext=Losodeli")

          expect(page).to have_content("Losodeli")
          expect(page).to_not have_content("Casa")
          expect(page).to_not have_content("Toucan")

        end

        it "when you have a partial match of one of the records, it will return a page with only the record that you searched for" do 

          visit "/hotels"
          fill_in "searchtext", with: "asa"
          click_button "Search"

    
          expect(page).to have_current_path("/hotels?searchtext=asa")
    
          expect(page).to have_content("Casa Flow")
          expect(page).to_not have_content("Toucan")
          expect(page).to_not have_content("Losodeli")
    
        end
      end 

      describe "additional functionality/usability added for convenience by the coder" do 
        it "when a user clicks is on the index and clicks on the name of the guest, they will be taken to their show page" do 

        visit "/hotels"

        click_link "#{@hotel1.name}"

        expect(page).to have_current_path("/hotels/#{@hotel1.id}")
        expect(page).to have_content("Casa Flow")
        expect(page).to_not have_content("Losodeli")
      end
    end 
  end 
end 
end 