require 'rails_helper'

RSpec.describe 'as a user of the page' do
   describe "when a user of the page visits '/guest'" do 
    it "displays all of the guests and their attributes " do # user story 3
    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    

    visit "/guests"

    expect(page).to have_content(guest1.name)
    expect(page).to have_content(guest1.price_per_night_pesos)
    expect(page).to have_content(guest1.spanish_speaker)
    expect(page).to have_content(guest2.name)
    expect(page).to have_content(guest2.price_per_night_pesos)
    expect(page).to have_content(guest2.spanish_speaker)

    expect(page).to_not have_content(hotel1.name)

    end
  end 
end


