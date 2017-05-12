require 'rails_helper'

RSpec.describe "residents/edit", type: :view do
  before(:each) do
    @resident = assign(:resident, Resident.create!())
  end

  it "renders the edit resident form" do
    render

    assert_select "form[action=?][method=?]", resident_path(@resident), "post" do
    end
  end
end
