require 'rails_helper'

RSpec.describe "meters/edit", type: :view do
  before(:each) do
    @meter = assign(:meter, Meter.create!())
  end

  it "renders the edit meter form" do
    render

    assert_select "form[action=?][method=?]", meter_path(@meter), "post" do
    end
  end
end
