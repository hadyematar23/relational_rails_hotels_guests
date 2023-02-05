require 'rails_helper'

RSpec.describe Hotel, type: :model do 
  describe "associations" do 
    it {should have_many :guests}
  end

  describe 'instance_methods' do 
    it "can associate each guest with the hotel" do #User story 5- model method

      hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)

      hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)

      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)

      guest2 = hotel2.guests.create!(name: "Malena", price_per_night_pesos: 454, spanish_speaker: false)

      guest3 = hotel1.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

      expect(hotel1.list_guests_by_hotel_id).to eq([guest1, guest3])
    end

    it 'can order the hotels by the most recently created first' do #User Story 6- model method 

      hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55, created_at: Time.zone.parse("2022-01-01 12:00:00"))
      hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346, created_at: Time.zone.parse("2022-01-02 12:00:00"))
      hotel3 = Hotel.create!(name: "Toucan", starlink:false, meters_from_beach: 375, created_at: Time.zone.parse("2021-01-01 12:00:00"))

      expect(Hotel.order_hotels).to eq([hotel2, hotel1, hotel3])

    end

    it "can count the number of guests" do #user story 7 model method

      hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

      expect(hotel1.count_guests).to eq(2)

    end

    it "will return a false on the boolean if there is no value on the key 'Starlink'" do 

      hotel1 = Hotel.create!(name: "Losodeli", starlink: nil, meters_from_beach: 346)

      params = {
      :hotel=>{"name"=>"Diego's House", "meters"=>"355"},
      :Starlink=>"", 
      :controller=>"hotels", 
      :action=>"update", 
      :id =>"779"}

      expect(hotel1.boolean_print(params)).to eq("true")

      params = {
      :hotel=>{"name"=>"Diego's House", "meters"=>"355"},
      :controller=>"hotels", 
      :action=>"update", 
      :id =>"779"}

      expect(hotel1.boolean_print(params)).to eq("false")

    end

    it "will return only the guests that are paying above the chosen price per night" do 

      hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)

      pesos = 600
      expect(hotel1.meet_threshold(pesos)).to eq([guest1])


    end

    it "will sort the Hotels by the number of guests each of them has" do 

      @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @hotel3 = Hotel.create!(name: "Toucan", starlink: false, meters_from_beach: 450) #may have to delete this hotel
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
      @guest4 = @hotel2.guests.create!(name: "Michele", price_per_night_pesos: 500, spanish_speaker: true)
      @guest5 = @hotel2.guests.create!(name: "Radim", price_per_night_pesos: 400, spanish_speaker: false)
      @guest6 = @hotel2.guests.create!(name: "Cayne", price_per_night_pesos: 300, spanish_speaker: true)
      @guest7 = @hotel2.guests.create!(name: "Farhad", price_per_night_pesos: 100, spanish_speaker: false)
      @guest8 = @hotel2.guests.create!(name: "Radim", price_per_night_pesos: 200, spanish_speaker: true)
      @guest9 = @hotel1.guests.create!(name: "Caroline", price_per_night_pesos: 800, spanish_speaker: false)
      @hotel4 = Hotel.create!(name: "TreeHouse", starlink: true, meters_from_beach: 1000)
      @guest10 = @hotel4.guests.create!(name: "Guest10", price_per_night_pesos: 800, spanish_speaker: true)
      @guest11 = @hotel4.guests.create!(name: "Guest11", price_per_night_pesos: 600, spanish_speaker: false)


      require 'pry'; binding.pry

      expect(Hotel.sort_by_number).to eq([@hotel2, @hotel1, @hotel4, @hotel3])

    end

    it "will return the element in an array if there is an exact match for it" do 
      @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @hotel3 = Hotel.create!(name: "Toucan", starlink: false, meters_from_beach: 450) #may have to delete this hotel
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)

      params = {searchtext: "Casa Flow"}
      expect(Hotel.search(params)).to eq([@hotel1])
    end

  end
end