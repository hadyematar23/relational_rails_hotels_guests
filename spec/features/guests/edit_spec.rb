require 'rails_helper'

RSpec.describe 'as a user of the guests index page' do
   describe "when a user of the page visits '/guests'" do 
    before(:each) do 
      @hotel1 = Hotel.create!(name: "Losodeli", starlink: false, meters_from_beach: 346)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @hotel2 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest2 = @hotel2.guests.create!(name: "Malena", price_per_night_pesos: 780, spanish_speaker: true)
      @guest3 = @hotel2.guests.create!(name: "Diego", price_per_night_pesos: 12, spanish_speaker: true)
   end

   it "when once clicks on the link to edit the guests info, they are taken to the edit page to do so" do 

    visit "/guests"
   
    click_link "Edit #{@guest1.name}'s Information" 
  
    expect(page).to have_current_path("/guests/#{@guest1.id}/edit")
    expect(page).to have_selector("form")
    expect(page).to have_content("Update Guest Name")
    expect(page).to have_content("Update Price per Night")
    expect(page).to have_content("Update Guest Spanish Status")
  end

  it "clicking the link of update guest takes to a page '/guests/:id/edit' where there is a form to update the guests's attributes" do 
    
    visit "/guests/#{@guest2.id}"

    click_link "Update Guest"

    expect(page).to have_current_path("/guests/#{@guest2.id}/edit")
    expect(page).to have_selector("form")
    expect(page).to have_content("Update Guest Name")
    expect(page).to have_content("Update Guest Spanish Status")
    expect(page).to have_content("Update Price per Night")
    
  end

  it "after filling in the form of update guest link and clicking the 'Update Guest' button, the guest's data is updated and the user is redirected to the child's showpage and displays the updated info" do 

    visit "/guests/#{@guest2.id}/edit"
# save_and_open_page
    fill_in 'name', with: "Abraham"
    fill_in 'price_per_night_pesos', with: "420"
    check "spanish_speaker"

    click_button("Update Guest")
    
    expect(page).to have_current_path("/guests/#{@guest2.id}")
    expect(page).to have_content("Abraham")
    expect(page).to have_content(420)
    expect(page).to_not have_content(780)

  end
end 
end 