require 'rails_helper'

RSpec.describe 'as a user of the page' do
   describe "when a user of the page visits '/guests'" do 
    it "displays all of the guests and their attributes " do # user story 3
      hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      

      visit "/guests"
      
      expect(page).to have_content(guest1.name)
      expect(page).to have_content(guest1.price_per_night_pesos)
      expect(page).to have_content(guest1.spanish_speaker)

      expect(page).to_not have_content(hotel1.name)

    end

    it "The user will only see the records where the guest is a Spanish speaker(boolean is true)" do 

      hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

      visit "/guests"

      expect(page).to have_content(guest1.name)
      expect(page).to have_content(guest3.name)
      expect(page).to_not have_content(guest2.name)

    end 

    it "next to each guest there is a link to edit that guest's information" do 

      hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

      visit "/guests"
        
      expect(page).to have_link("Edit #{guest1.name}'s Information", href: "/guests/#{guest1.id}/edit")

    end

    it "when once clicks on the link to edit the guests info, they are taken to the edit page to do so" do 

      hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest2 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

      visit "/guests"
     
      click_link "Edit #{guest1.name}'s Information" 
    
      expect(page).to have_current_path("/guests/#{guest1.id}/edit")
      expect(page).to have_selector("form")
      expect(page).to have_content("Update Guest Name")
      expect(page).to have_content("Update Price per Night")
      expect(page).to have_content("Update Guest Spanish Status")
    end

    describe "deleting from the index page directly" do 
    before(:each) do 
      @hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest2 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
    end 

    it "next to every guest there is a link to delete the guest" do

      visit "/guests"

      expect(page).to have_link("Delete #{@guest1.name}", href: "/guests/#{@guest1.id}")
      expect(page).to have_link("Delete #{@guest1.name}", href: "/guests/#{@guest1.id}")

    end

    it "after clicking the link, the guest is deleted and the user ir rerouted back to the guests index page" do 

      visit "/guests"

      click_link "Delete #{@guest1.name}"
          
      expect(page).to have_current_path("/guests")
      expect(page).to have_content(@guest2.name)
      expect(page).to_not have_content(@guest1.name)

    end 

    end 
  end #"when a user of the page visits '/guests'"
end # 'as a user of the page'


