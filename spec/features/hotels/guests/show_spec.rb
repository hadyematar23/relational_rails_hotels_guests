require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe "a customized link to update each child is located next to each child's name when on the index page" do
    before(:each) do 
      @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true, hotel_id: @hotel1.id)
      @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
      @guest4 = @hotel2.guests.create!(name: "Michele", price_per_night_pesos: 500, spanish_speaker: true)
      @guest5 = @hotel2.guests.create!(name: "Radim", price_per_night_pesos: 400, spanish_speaker: false)
      @guest6 = @hotel2.guests.create!(name: "Kain", price_per_night_pesos: 300, spanish_speaker: true)
      @guest7 = @hotel1.guests.create!(name: "Farhad", price_per_night_pesos: 100, spanish_speaker: false)
      @guest8 = @hotel1.guests.create!(name: "Radim", price_per_night_pesos: 200, spanish_speaker: true)
    end

    it "next to each child the link exists" do 

      visit "/hotels/#{@hotel1.id}/guests"
        
      expect(page).to have_link("Edit #{@guest1.name}'s Information", href: "/guests/#{@guest1.id}/edit")

    end 

    it "when you click on the link, it will take you to the form where you can edit the guest's information" do 

      visit "/hotels/#{@hotel1.id}/guests"

      click_link "Edit #{@guest1.name}'s Information" 

      expect(page).to have_current_path("/guests/#{@guest1.id}/edit")
      expect(page).to have_selector("form")
      expect(page).to have_content("Update Guest Name")
      expect(page).to have_content("Update Price per Night")
      expect(page).to have_content("Update Guest Spanish Status")

    end
  end 
end 