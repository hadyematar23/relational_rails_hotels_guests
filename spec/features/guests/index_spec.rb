require 'rails_helper'

RSpec.describe 'as a user of the guests index page' do
   describe "when a user of the page visits '/guests'" do 

    before(:each) do 
      @hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest2 = @hotel2.guests.create!(name: "Malena", price_per_night_pesos: 545, spanish_speaker: false)
      @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
   end

    it "displays all of the guests and their attributes " do 
  
      visit "/guests"
      
      expect(page).to have_content(@guest1.name)
      expect(page).to have_content(@guest1.price_per_night_pesos)
      expect(page).to have_content(@guest1.spanish_speaker)
      expect(page).to have_content(@guest3.name)
      expect(page).to have_content(@guest3.price_per_night_pesos)
      expect(page).to have_content(@guest3.spanish_speaker)

      expect(page).to_not have_content(@hotel1.name)
      expect(page).to_not have_content(@hotel2.name)

    end

    it "The user will only see the records where the guest is a Spanish speaker(boolean is true)" do 

      visit "/guests"

      expect(page).to have_content(@guest1.name)
      expect(page).to have_content(@guest3.name)
      expect(page).to_not have_content(@guest2.name)

    end 

    it "next to each guest there is a link to edit that guest's information" do 

      visit "/guests"
        
      expect(page).to have_link("Edit #{@guest1.name}'s Information", href: "/guests/#{@guest1.id}/edit")

    end

    it "next to every guest there is a link to delete the guest" do

      visit "/guests"

      expect(page).to have_link("Delete #{@guest1.name}", href: "/guests/#{@guest1.id}")
      expect(page).to have_link("Delete #{@guest1.name}", href: "/guests/#{@guest1.id}")

    end

    describe "Extension: doing an exact search" do 
      it "when you got to the index page there is a text box that will filter results by keyword" do 
       
        visit "/guests"

        expect(page).to have_selector("form")
        expect(page).to have_content("Search for Guest")
        expect(page).to have_button("Search")

    end

    it "when you have an exact match of one of the records, it will return a page with only the record that you searched for" do 

      visit "/guests"
      
      fill_in "searchtext", with: "Diego"
      click_button "Search"

      expect(page).to have_current_path("/guests?searchtext=Diego")

      expect(page).to have_content("Diego")
      expect(page).to_not have_content("Hady")

    end

    it "when you have a partial match of one of the records, it will return a page with only the record that you searched for" do 

      visit "/guests"
      fill_in "searchtext", with: "Die"
      click_button "Search"

      expect(page).to have_current_path("/guests?searchtext=Die")

      expect(page).to have_content("Diego")
      expect(page).to_not have_content("Hady")

    end

    describe "Added for user funtionality" do 
      it "when a user clicks is on the index and clicks on the name of the guest, they will be taken to their show page" do 

        visit "/guests"
        
        click_link "#{@guest1.name}"

        expect(page).to have_current_path("/guests/#{@guest1.id}")
        expect(page).to have_content("Hady")
        expect(page).to_not have_content("Diego")
      end
    end 
    end 
  end 
end 


