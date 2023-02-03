require 'rails_helper'

RSpec.describe 'for the guests of each hotel' do
  describe "when the user visits '/hotels/:hotel_id/guest'" do 
    it "it displays each Child that is associated with that Parent, along with each Child's attributes" do #user story 5- feature method 

    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)

    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
    guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

    visit "/hotels/#{hotel1.id}/guests"

    expect(page).to have_content(guest1.name)
    expect(guest1.name).to eq("Hady")
    expect(page).to have_content(guest2.name)
    expect(guest2.name).to eq("Malena")
    expect(page).to have_content(guest1.price_per_night_pesos)
    expect(page).to have_content(guest2.price_per_night_pesos)
    expect(page).to have_content(guest1.spanish_speaker)
    expect(page).to have_content(guest2.spanish_speaker)
    expect(page).to have_content(guest1.updated_at)
    expect(page).to have_content(guest1.created_at)
    expect(page).to have_content(guest2.updated_at)
    expect(page).to have_content(guest2.created_at)
    expect(page).to_not have_content(guest3.name)
    end 
  end
end 