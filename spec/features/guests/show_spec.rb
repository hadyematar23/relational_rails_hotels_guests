require 'rails_helper'

RSpec.describe 'as a user' do
   describe "when the user visits '/child_table_name/:id'" do 
    it "displays the individual guests and their attributes " do #user story 4
    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)

    visit "/guests/#{guest1.id}"

    expect(page).to have_content(guest1.name)
    expect(page).to have_content(guest1.price_per_night_pesos)
    expect(page).to have_content(guest1.spanish_speaker)
    expect(page).to have_content(guest1.updated_at)
    expect(page).to have_content(guest1.created_at)
    expect(page).to_not have_content(guest2.name)
    expect(guest1.name).to eq("Hady")

    end
  end 

  it "displays the individual guests and their attributes " do 
    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)

    visit "/guests/#{guest2.id}"

    expect(page).to have_content(guest2.name)
    expect(page).to have_content(guest2.price_per_night_pesos)
    expect(page).to have_content(guest2.spanish_speaker)
    expect(page).to have_content(guest2.updated_at)
    expect(page).to have_content(guest2.created_at)
    expect(page).to_not have_content(guest1.name)
    expect(guest2.name).to eq("Malena")

  end

  it "displays a link to update 'Update Guest'" do #when visiting a child show page

    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)

    visit "/guests/#{guest2.id}"

    expect(page).to have_link("Update Guest", href: "/guests/#{guest2.id}/edit")
  end 

  it "clicking the link takes to a page '/guests/:id/edit' where there is a form to update the guests's attributes" do 

    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    
    visit "/guests/#{guest2.id}"

    click_link "Update Guest"

    expect(page).to have_current_path("/guests/#{guest2.id}/edit")
    expect(page).to have_selector("form")
    expect(page).to have_content("Update Guest Name")
    expect(page).to have_content("Update Guest Spanish Status")
    expect(page).to have_content("Update Price per Night")
    
  end

  it "after filling in the form and clicking the 'Update Guest' button, the guest's data is updated and the user is redirected to the child's showpage and displays the updated info" do 

    hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
    guest1 = hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
    guest2 = hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)

    visit "/guests/#{guest2.id}/edit"

    fill_in "guest[name]", with: "Abraham"
    fill_in "guest[price]", with: 420
    check "Spanish"

    click_button("Update Guest")
    
    expect(page).to have_current_path("/guests/#{guest2.id}")
    expect(page).to have_content("Abraham")
    expect(page).to have_content("true")
    expect(page).to_not have_content("false")

  end

  describe "deleting the guest" do 
    before(:each)do 
      @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
      @hotel2 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
      @guest4 = @hotel2.guests.create!(name: "Michele", price_per_night_pesos: 500, spanish_speaker: true)
      @guest5 = @hotel2.guests.create!(name: "Radim", price_per_night_pesos: 400, spanish_speaker: false)
      @guest6 = @hotel2.guests.create!(name: "Kain", price_per_night_pesos: 300, spanish_speaker: true)
      @guest7 = @hotel1.guests.create!(name: "Farhad", price_per_night_pesos: 100, spanish_speaker: false)
      @guest8 = @hotel1.guests.create!(name: "Radim", price_per_night_pesos: 200, spanish_speaker: true)
    end

    it "on the individual guest show page it shows a link to delete the guest" do 

      visit "/guests/#{@guest1.id}"
      
      expect(page).to have_link("Delete Guest", href: "/guests/#{@guest1.id}")

    end

    it "once you click the link of 'Delete Guest', the guest are deleted and you are returned to the child index page" do 

      visit "/guests/#{@guest1.id}"

      click_link "Delete Guest"
      expect(page).to have_current_path("/guests")
      expect(page).to_not have_content(@guest1.name)
      expect(page).to have_content(@guest8.name)
    end
  end #deleting the guest 

end 
