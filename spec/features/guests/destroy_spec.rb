require 'rails_helper'

RSpec.describe 'as a user of the guests index page' do
   describe "when a user of the page visits '/guests'" do 
    describe "deleting from the index page directly" do 
    before(:each) do 
      @hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest2 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
    end 

    it "after clicking the link to delete, the guest is deleted and the user ir rerouted back to the guests index page" do 

      visit "/guests"

      click_link "Delete #{@guest1.name}"
          
      expect(page).to have_current_path("/guests")
      expect(page).to have_content(@guest2.name)
      expect(page).to_not have_content(@guest1.name)

    end 

    it "once you click the link of 'Delete Guest', the guest are deleted and you are returned to the child index page" do 

      visit "/guests/#{@guest1.id}"

      click_link "Delete Guest"
      expect(page).to have_current_path("/guests")
      expect(page).to_not have_content(@guest1.name)
      expect(page).to have_content(@guest2.name)
    end
   end
  end 
end 