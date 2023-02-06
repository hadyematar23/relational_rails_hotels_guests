require 'rails_helper'

RSpec.describe 'as a visitor' do
  it "the welcome page does not say welcome to rails but says welcome to Puerto Escondido" do 
    visit "/"
    expect(page).to have_content("Welcome to Puerto Escondido")
  end
end
  