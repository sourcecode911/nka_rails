require 'rails_helper'

RSpec.describe "meters/new", type: :view do
  before(:each) do
    assign(:meter, Meter.new())
  end

  it "renders new meter form" do
    render

    assert_select "form[action=?][method=?]", meters_path, "post" do
    end
  end
end
