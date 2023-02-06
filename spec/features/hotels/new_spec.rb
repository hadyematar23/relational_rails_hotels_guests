require 'rails_helper'

RSpec.describe 'for each hotel table' do
   describe "as a visitor" do 

    before :each do 
      @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55, created_at: Time.zone.parse("2022-01-01 12:00:00"))
      @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346, created_at: Time.zone.parse("2023-01-02 12:00:00"))
      @hotel3 = Hotel.create!(name: "Toucan", starlink:false, meters_from_beach: 375, created_at: Time.zone.parse("2021-01-01 12:00:00"))
    end

      it "the visitor clicks on the new hotel page link and is taken to the form to create a new hotel" do
        visit "/hotels"
        click_link "Add New Hotel"
        
        expect(page).to have_current_path("/hotels/new")

      end 

      it "the visitor is redirected to the hotels index form which now has the information they previoulsy input about the hotel listed" do 
          
        visit "/hotels/new"

        fill_in "Name", with: "Puerto Dreams"
        check "Starlink"
        fill_in "Meters from Beach", with: "255"

        click_button("Create Hotel")
        expect(current_path).to eq('/hotels')
        expect(page).to have_content("Puerto Dreams")
        expect(page).to have_content("Has starlink? true")
        expect(page).to have_content("255")

      end 

      it "testing without a checkmark on the starlink" do 

        visit "/hotels/new"

        fill_in "Name", with: "Puerto Dreams"
        fill_in "Meters from Beach", with: "255"

        click_button("Create Hotel")

        expect(current_path).to eq('/hotels')
        expect(page).to have_content("Puerto Dreams")
        expect(page).to have_content("Has starlink? false")
        expect(page).to have_content("255")

      end

      it "by submitting a form, a new hotel has been created" do 
        expect(Hotel.all.count).to eq(3)
        visit "/hotels/new"

        fill_in "Name", with: "Puerto Dreams"
        check "Starlink"
        fill_in "Meters from Beach", with: "255"

        click_button("Create Hotel")

        expect(Hotel.all.count).to eq(4)
    
      end 
    end 
   end