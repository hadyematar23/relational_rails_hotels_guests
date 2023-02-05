require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe "when the user visits '/hotels/:hotel_id/guests'" do 
    it "it diplays each Child that is associated with that Parent, along with each Child's attributes" do #user story 5- feature method 

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

  it "displays a link to a new adoptable guest for this hotel titled 'Create Guest'" do 
    hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)


    visit "/hotels/#{hotel2.id}/guests"
    
    expect(page).to have_link("Add Guest", href: "/hotels/#{hotel2.id}/guests/new")
  end

  it "when clicking the link titled 'Create Guest', you are taken to a new page '/hotels/:hotel_id/guests/new' where the user sees a form where they can add a new Guest" do 

    hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest3 = hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
          
    visit "/hotels/#{hotel2.id}/guests"

    click_link "Add Guest"

    expect(page).to have_current_path("/hotels/#{hotel2.id}/guests/new")

    expect(page).to have_selector("form")
    expect(page).to have_content("Add New Guest")
    expect(page).to have_content("Check if Spanish Speaker")
    expect(page).to have_content("MXP Price Per Night")

  end 

  describe "the user fills in the form, clicks the button to create a child, a post request is sent to '/hotels/:hotel_id/guests" do 
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
    it "and a new guest object is created for that hotel and is shown on the page to which the user is redirected" do 

      visit "/hotels/#{@hotel1.id}/guests/new"
      expect(Guest.all.count).to eq(8)

      fill_in "Name", with: "Sebastian"
      check "Spanish_Speaker"
      fill_in "MXP_per_night", with: "1500"

      click_button("Create Guest")

      expect(Guest.all.count).to eq(9)
      expect(page).to have_current_path("/hotels/#{@hotel1.id}/guests")
      expect(page).to have_content("Sebastian")
      expect(page).to have_content("1500")

    end


  it "displays a link to sort the guests in alphabetical order" do 
  
    visit "/hotels/#{@hotel1.id}/guests"
    save_and_open_page

    expect(page).to have_link("Sort Guests Alphabetically", href: "/hotels/#{@hotel1.id}/guests?alpha=true")

  end 

  it "after clicking on the link, the user is returned to the hotel's guest index page that shows all of the guests in alphabetical order" do 

    visit "/hotels/#{@hotel1.id}/guests"
    click_link "Sort Guests Alphabetically"
    
    expect(current_path).to eq("/hotels/#{@hotel1.id}/guests")
    expect(@guest1.name).to appear_before(@guest2.name)
    expect(@guest7.name).to appear_before(@guest1.name)
    expect(@guest2.name).to appear_before(@guest8.name)
    expect(@guest2.name).to_not appear_before(@guest7.name)

  end 
  end

  describe "a customized link to update each child is located next to each child's name when on the index page" do
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

    it "next to each child the link exists" do 

      visit "/hotels/#{@hotel1.id}/guests"
        
      expect(page).to have_link("Edit #{@guest1.name}'s Information", href: "/guests/#{@guest1.id}/edit")

    end 

    it "when you click on the link, it will take you to the form where you can edit the guest's information" do 

      visit "/hotels/#{@hotel1.id}/guests"

      click_link "Edit #{@guest1.name}'s Information" 

      expect(page).to have_current_path("/guests/#{@guest1.id}/edit")
      expect(page).to have_selector("form")
      expect(page).to have_content("Update Guest Name")
      expect(page).to have_content("Update Price per Night")
      expect(page).to have_content("Update Guest Spanish Status")

    end

    describe "Displaying records over a give threnshold" do 
      it "there is a form that allows the visitor to input a numeric value and has a submit button that reads 'Only return records with more than 'CHOOSE NUMBER' Pesos per night'" do 

        visit "/hotels/#{@hotel1.id}/guests"
save_and_open_page
        expect(page).to have_selector("form")
        expect(page).to have_content("pesos")
        expect(page).to have_button("Only return records with more than your chosen peso threshold per night")
        
      end

      it "after inputting a numeric value and clicking the submit button, the user is brought back to the hotel_guests index page only showing the records that meet that threshold" do 

        visit "/hotels/#{@hotel1.id}/guests"

        fill_in "pesos", with: "300"

        click_button("Only return records with more than your chosen peso threshold per night")
        
        expect(page).to have_current_path("/hotels/#{@hotel1.id}/guests?pesos=300")

        expect(page).to have_content("Hady")
        expect(page).to_not have_content("Farhad")
        expect(page).to_not have_content("Radim")

      end


    end

  end #"a customized link to update each child is located next to each child's name when on the index page"
  end #when person visits hotels/id/guests
end #big Rspec closer- as a visitor