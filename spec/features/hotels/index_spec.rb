require 'rails_helper'

RSpec.describe 'for each hotel table' do
   describe "as a visitor" do 

    describe "when the user visits '/hotels'" do 
      it 'displays all of the hotels at the index page' do #user story 1 
        
        hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)

        visit '/hotels'

        expect(page).to have_content(hotel1.name)
        expect(page).to have_content(hotel2.name)
        end
      end 
 
    
    describe "when the user visits /hotels" do #User Story 6- 
      before :each do 
        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55, created_at: Time.zone.parse("2022-01-01 12:00:00"))
        @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346, created_at: Time.zone.parse("2023-01-02 12:00:00"))
        @hotel3 = Hotel.create!(name: "Toucan", starlink:false, meters_from_beach: 375, created_at: Time.zone.parse("2021-01-01 12:00:00"))
      end

      it "displays the hotels by the time when their records were created in the system " do 

        visit "/hotels"
          
        expect(@hotel2.name).to appear_before(@hotel1.name)
        expect(@hotel1.name).to appear_before(@hotel3.name)
      end 
    end 

    describe "when the visitor visits the hotel index page" do #User story 11 
      before :each do 
        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      end

      it "the visit sees the link to create a new hotel page" do 

        visit "/hotels"
        expect(page).to have_link('Add New Hotel', href: "/hotels/new")

      end

      describe "the visitor clicks the new hotel page link" do
        it "the visitor is taken to the form to create a new hotel" do
          visit "/hotels"
          click_link "Add New Hotel"
          
          expect(page).to have_current_path("/hotels/new")

        end  
      end 

      describe "the visitor fills out the form, clicks the button 'Create Hotel' to submit the form" do #this is after the user has filled up the HTML page, submitted it, and then the HTML page sends HTTP request to POST  /hotels which takes us to hotels#create action, which, after making us new hotel using information from the form, then sends us back to new hotels index  
        it "the visitor is redirected to the hotels index form which now has the information they previoulsy input about the hotel listed" do 
          
          visit "/hotels/new"

          fill_in "Name", with: "Puerto Dreams"
          check "Starlink"
          fill_in "Meters from Beach", with: "255"

          click_button("Create Hotel")
    
          expect(current_path).to eq('/hotels')
          expect(page).to have_content("Puerto Dreams")
          expect(page).to have_content("Has starlink? true")
          expect(page).to have_content("255")

        end 

        it "testing without a checkmark on the starlink" do 

          visit "/hotels/new"

          fill_in "Name", with: "Puerto Dreams"
          fill_in "Meters from Beach", with: "255"

          click_button("Create Hotel")

          expect(current_path).to eq('/hotels')
          expect(page).to have_content("Puerto Dreams")
          expect(page).to have_content("Has starlink? false")
          expect(page).to have_content("255")

        end

        it "by submitting a form, a new hotel has been created" do 
          expect(Hotel.all.count).to eq(2)
          visit "/hotels/new"

          fill_in "Name", with: "Puerto Dreams"
          check "Starlink"
          fill_in "Meters from Beach", with: "255"

          click_button("Create Hotel")

          expect(Hotel.all.count).to eq(3)
      
        end 
      end #"the visitor fills out the form, clicks the button 'Create Hotel' to submit the form" 

      it "next to every hotel there is a link to edit the parent's information " do 

        visit "/hotels"
        
        expect(page).to have_link("Edit #{@hotel1.name}'s Information", href: "/hotels/#{@hotel1.id}/edit")
      end

      it "when click on the link, there is an edit page to update the info" do #/parents/:id/edit' 

        visit "/hotels"
        click_link "Edit #{@hotel1.name}'s Information" 

        expect(page).to have_selector("form")
        expect(page).to have_content("Update Hotel Name")
        expect(page).to have_content("Update Hotel Starlink Status")
        expect(page).to have_content("Update Hotel Meters from Beach")

      end 
      
      it "next to every parent there is a link to delete the parent" do 

        visit "/hotels"
        expect(page).to have_link("Delete #{@hotel1.name}", href: "/hotels/#{@hotel1.id}")
        expect(page).to have_link("Delete #{@hotel2.name}", href: "/hotels/#{@hotel2.id}")

      end

      it "once you click on the link, the hotel is deleted and you are returned to the hotels index page" do 

        visit "/hotels"
        click_link "Delete #{@hotel1.name}" 

        expect(page).to have_content(@hotel2.name)
        expect(page).to_not have_content(@hotel1.name)

      end
    end

      describe "it sorts parents by the number of children" do 
        before(:each) do 

          @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
          @hotel3 = Hotel.create!(name: "Toucan", starlink: false, meters_from_beach: 450) #may have to delete this hotel
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

    describe "extension 2: searching by name exact match" do 
      before(:each) do 

        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        @hotel3 = Hotel.create!(name: "Toucan", starlink: false, meters_from_beach: 450) #may have to delete this hotel
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
    end
  end #AS A VISITOR
end #GENERAL RSPEC