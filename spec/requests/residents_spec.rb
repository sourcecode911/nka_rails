require 'rails_helper'

RSpec.describe "Residents", type: :request do
  describe "GET /residents" do
    it "works! (now write some real specs)" do
      get residents_path
      expect(response).to have_http_status(200)
    end
  end
end
