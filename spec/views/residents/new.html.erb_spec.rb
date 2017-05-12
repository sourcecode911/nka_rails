require 'rails_helper'

RSpec.describe "residents/new", type: :view do
  before(:each) do
    assign(:resident, Resident.new())
  end

  it "renders new resident form" do
    render

    assert_select "form[action=?][method=?]", residents_path, "post" do
    end
  end
end
