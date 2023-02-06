require 'rails_helper'

RSpec.describe 'for each hotel table' do
   describe "as a visitor" do 
    describe "the destroy action" do 

      before :each do 
        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55, created_at: Time.zone.parse("2022-01-01 12:00:00"))
        @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346, created_at: Time.zone.parse("2023-01-02 12:00:00"))
        @hotel3 = Hotel.create!(name: "Toucan", starlink:false, meters_from_beach: 375, created_at: Time.zone.parse("2021-01-01 12:00:00"))
      end

      it "once you click to delete the hotel on index page on the link, the hotel is deleted and you are returned to the hotels index page" do 

        visit "/hotels"
        click_link "Delete #{@hotel1.name}" 
        expect(page).to have_current_path("/hotels")

        expect(page).to have_content(@hotel2.name)
        expect(page).to_not have_content(@hotel1.name)

      end
    end 
  end 
end 