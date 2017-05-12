require 'rails_helper'

RSpec.describe "residents/index", type: :view do
  before(:each) do
    assign(:residents, [
      Resident.create!(),
      Resident.create!()
    ])
  end

  it "renders a list of residents" do
    render
  end
end
