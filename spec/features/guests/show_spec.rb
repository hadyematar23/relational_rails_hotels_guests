require 'rails_helper'

RSpec.describe 'as a user' do
   describe "when the user visits '/child_table_name/:id'" do 
    before(:each) do 
      @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      @guest1 = @hotel1.guests.create!(name: "Hady", price_per_night_pesos: 650, spanish_speaker: true)
      @guest2 = @hotel1.guests.create!(name: "Malena", price_per_night_pesos: 550, spanish_speaker: false)
    end
 
    it "displays the individual guests and their attributes " do #user story 4

      visit "/guests/#{@guest1.id}"

      expect(page).to have_content(@guest1.name)
      expect(page).to have_content(@guest1.price_per_night_pesos)
      expect(page).to have_content(@guest1.spanish_speaker)
      expect(page).to have_content(@guest1.updated_at)
      expect(page).to have_content(@guest1.created_at)
      expect(page).to_not have_content(@guest2.name)
      expect(@guest1.name).to eq("Hady")

    end


  it "displays the individual guests and their attributes " do 

    visit "/guests/#{@guest2.id}"

    expect(page).to have_content(@guest2.name)
    expect(page).to have_content(@guest2.price_per_night_pesos)
    expect(page).to have_content(@guest2.spanish_speaker)
    expect(page).to have_content(@guest2.updated_at)
    expect(page).to have_content(@guest2.created_at)
    expect(page).to_not have_content(@guest1.name)
    expect(@guest2.name).to eq("Malena")

  end

  it "displays a link to update 'Update Guest'" do 

    visit "/guests/#{@guest2.id}"

    expect(page).to have_link("Update Guest", href: "/guests/#{@guest2.id}/edit")
  end 

  it "on the individual guest show page it shows a link to delete the guest" do 

    visit "/guests/#{@guest1.id}"
    
    expect(page).to have_link("Delete Guest", href: "/guests/#{@guest1.id}")

  end
end 
end 
