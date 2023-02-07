require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe "deleting from the hotel-guest index directly" do  
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

    it "next to every guest name in any hotel-guest index, there exists a link to delet the guest" do 
      visit "/hotels/#{@hotel1.id}/guests"
      expect(page).to have_link("Delete #{@guest1.name}", href: "/guests/#{@guest1.id}")
      expect(page).to have_link("Delete #{@guest1.name}", href: "/guests/#{@guest1.id}")
    end

    it "once you click on the link, the hotel is deleted and you are returned to the hotels index page" do 

      visit "/hotels/#{@hotel1.id}/guests"
      expect(page).to have_content(@guest1.name)
      click_link "Delete #{@guest1.name}" 
      expect(page).to_not have_content(@guest1.name)
      expect(page).to have_content(@guest8.name)
    end
  end
end






