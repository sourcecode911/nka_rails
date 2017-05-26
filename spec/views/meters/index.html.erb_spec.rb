require 'rails_helper'

RSpec.describe "meters/index", type: :view do
  before(:each) do
    assign(:meters, [
      Meter.create!(),
      Meter.create!()
    ])
  end

  it "renders a list of meters" do
    render
  end
end
