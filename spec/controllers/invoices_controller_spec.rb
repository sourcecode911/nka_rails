require 'rails_helper'


RSpec.describe InvoicesController, type: :controller do
  describe 'GET Index' do
    it('has status code 200') do
      get :counts
      expect(response.status).to eq(200)
    end
  end

end
