require 'rails_helper'

  RSpec.describe 'Edit spec' do
    describe "as a visitor" do 
      before(:each) do 
        @hotel1 = Hotel.create!(name: "Casa Flow", starlink: true, meters_from_beach: 55)
      end


  it "clicking the update hotel link takes to a page '/hotels/:id/edit' where there is a form to update the hotel's attributes" do 

    visit "/hotels/#{@hotel1.id}"

    click_link "Update Hotel"

    expect(page).to have_current_path("/hotels/#{@hotel1.id}/edit")
    expect(page).to have_selector("form")
    expect(page).to have_content("Update Hotel Name")
    expect(page).to have_content("Update Hotel Starlink Status")
    expect(page).to have_content("Update Hotel Meters from Beach")
    
  end

  it "when on the hotels page and the user click on the link labeled Edit Information, there is an edit page to update the info" do 

    visit "/hotels"
    click_link "Edit #{@hotel1.name}'s Information" 

    expect(page).to have_current_path("/hotels/#{@hotel1.id}/edit")

    expect(page).to have_selector("form")
    expect(page).to have_content("Update Hotel Name")
    expect(page).to have_content("Update Hotel Starlink Status")
    expect(page).to have_content("Update Hotel Meters from Beach")
    

  end 
  
  describe "when the user fills out the form with updated info and click the submit button" do 
    it "we are redirected to the individual hotel's show page and the hotel's info has been updated" do 

      visit "/hotels/#{@hotel1.id}/edit"

      fill_in "hotel[name]", with: "Diego's House"
      fill_in "hotel[meters]", with: 355

      click_button("Update Hotel")
      
      expect(page).to have_current_path("/hotels/#{@hotel1.id}")
      expect(page).to have_content("Diego's House")
      expect(page).to have_content("false")
      expect(page).to_not have_content("true")
      
    end

    it "we are redirected to the individual hotel's show page and the hotel's info has been updated- test 2 with Starlink checked yes" do 

      visit "/hotels/#{@hotel1.id}/edit"

      fill_in "hotel[name]", with: "Diego's House"
      check "Starlink"
      fill_in "hotel[meters]", with: 355

      click_button("Update Hotel")
      
      expect(page).to have_current_path("/hotels/#{@hotel1.id}")
      expect(page).to have_content("Diego's House")
      expect(page).to have_content("true")
      expect(page).to_not have_content("false")
      
    end
  end 
end 
end 