require 'rails_helper'

RSpec.describe Guest, type: :model do 
  describe "associations" do 
    it {should belong_to :hotel}
  end
end 