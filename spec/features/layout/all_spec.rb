require 'rails_helper'

RSpec.describe "application page of the HTML.erb file" do
   describe "as a visitor" do 
     describe "when visiting any page on the site" do 
      it "displays at the top of the page a link to the Guest index" do#user story 8

        hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)

        visit "/hotels"
        expect(page).to have_link('Guests Index', href: "/guests")

        visit "/hotels/#{hotel1.id}"
        expect(page).to have_link('Guests Index', href: "/guests")

        visit '/guests'
        expect(page).to have_link('Guests Index', href: "/guests")

        visit "guests/#{guest1.id}"
        expect(page).to have_link('Guests Index', href: "/guests")

        visit "/hotels/#{hotel1.id}/guests"
        expect(page).to have_link('Guests Index', href: "/guests")

        visit "/individual_hotel/#{hotel1.id}"
        expect(page).to have_link('Guests Index', href: "/guests")

      end 

      it "see a link at the top of the page that takes me to the Parent Index" do 

        hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
        guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)

        visit "/hotels"
        expect(page).to have_link('Hotels Index', href: "/hotels")

        visit "/hotels/#{hotel1.id}"
        expect(page).to have_link('Hotels Index', href: "/hotels")

        visit '/guests'
        expect(page).to have_link('Hotels Index', href: "/hotels")

        visit "guests/#{guest1.id}"
        expect(page).to have_link('Hotels Index', href: "/hotels")

        visit "/hotels/#{hotel1.id}/guests"
        expect(page).to have_link('Hotels Index', href: "/hotels")

        visit "/individual_hotel/#{hotel1.id}"
        expect(page).to have_link('Hotels Index', href: "/hotels")
      end
    end 
  end 
end 