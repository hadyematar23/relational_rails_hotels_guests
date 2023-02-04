# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true, hotel_id: hotel1.id)
guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
guest4 = hotel2.guests.create!(name: "Michele", price_per_night_pesos: 500, spanish_speaker: true)
guest5 = hotel2.guests.create!(name: "Radim", price_per_night_pesos: 400, spanish_speaker: false)
guest6 = hotel2.guests.create!(name: "Kain", price_per_night_pesos: 300, spanish_speaker: true)
guest7 = hotel1.guests.create!(name: "Farhad", price_per_night_pesos: 100, spanish_speaker: false)
guest8 = hotel1.guests.create!(name: "Radim", price_per_night_pesos: 200, spanish_speaker: true)
