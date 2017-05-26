require 'rails_helper'

RSpec.describe "meters/show", type: :view do
  before(:each) do
    @meter = assign(:meter, Meter.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
