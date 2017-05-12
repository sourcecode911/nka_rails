require 'rails_helper'

RSpec.describe Invoice, type: :model do
  # Assure Invoice model has working 1:m relationship with invoice_details
  it { should have_many(:invoice_details).dependent(:destroy) }

  # Assure the Invoice model validates the presence of necessary attributes
  it { should validate_presence_of(:user_id ) }
  it { should validate_presence_of(:year ) }
  it { should validate_presence_of(:state ) }
  it { should validate_uniqueness_of(:year).scoped_to(:user_id) }
end
