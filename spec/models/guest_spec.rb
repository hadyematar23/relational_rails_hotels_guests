require 'rails_helper'

RSpec.describe Guest, type: :model do 
  describe "associations" do 
    it {should belong_to :hotel}
  end

  it "will return a false on the boolean if there is no value on the key 'Spanish_speaker" do 

    hotel1 = Hotel.create!(name: "Losodeli", starlink: nil, meters_from_beach: 346)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)

    params = {:Spanish=>"on"}

    expect(guest1.boolean_print(params)).to eq("true")

    params = {}

    expect(guest1.boolean_print(params)).to eq("false")
  end

  it "will select all of the Spanish Speakers" do 
    hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

    expect(Guest.select_spanish_speakers).to eq([guest1, guest3])

  end

  it "will return the element in an array if there is an exact match for it" do 
    @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    @hotel3 = Hotel.create!(name: "Toucan", starlink: false, meters_from_beach: 450) #may have to delete this hotel
    @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)

    params = {searchtext: "Malena"}
    expect(Guest.search(params)).to eq([@guest2])
  end


end 