require 'rails_helper'

RSpec.describe "application page of the HTML.erb file" do
   describe "as a visitor" do 
     describe "when visiting any page on the site" do 

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

        visit "/hotels/new"
        expect(page).to have_link('Hotels Index', href: "/hotels")

        visit "/hotels/#{hotel1.id}/edit"
        expect(page).to have_link('Hotels Index', href: "/hotels")
      end
    end 
  end 
end 