require 'rails_helper'

RSpec.describe "residents/show", type: :view do
  before(:each) do
    @resident = assign(:resident, Resident.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
