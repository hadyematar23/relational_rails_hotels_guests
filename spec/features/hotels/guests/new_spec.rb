require 'rails_helper'

RSpec.describe 'as a visitor' do
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

  it "when clicking the link titled 'Create Guest', you are taken to a new page '/hotels/:hotel_id/guests/new' where the user sees a form where they can add a new Guest" do 
          
    visit "/hotels/#{@hotel2.id}/guests"

    click_link "Add Guest"

    expect(page).to have_current_path("/hotels/#{@hotel2.id}/guests/new")

    expect(page).to have_selector("form")
    expect(page).to have_content("Add New Guest")
    expect(page).to have_content("Check if Spanish Speaker")
    expect(page).to have_content("MXP Price Per Night")

  end 

  describe "the user fills in the form, clicks the button to create a child, a post request is sent to '/hotels/:hotel_id/guests" do 
    it "and a new guest object is created for that hotel and is shown on the page to which the user is redirected" do 

      visit "/hotels/#{@hotel1.id}/guests/new"
      expect(Guest.all.count).to eq(8)

      fill_in "name", with: "Sebastian"
      check "spanish_speaker"
      fill_in "price_per_night_pesos", with: "1500"

      click_button("Create Guest")

      expect(Guest.all.count).to eq(9)
      expect(page).to have_current_path("/hotels/#{@hotel1.id}/guests")
      expect(page).to have_content("Sebastian")
      expect(page).to have_content("1500")

    end
  end 
end