require 'rails_helper'

RSpec.describe Subscription, type: :model do 
  describe "relationships" do 
    it { should belong_to(:tea) }
    it { should belong_to(:customer) }
  end
  describe "validations" do 
    Subscription.destroy_all
    Customer.destroy_all
    Tea.destroy_all

    customer = Customer.create!(email: 'unique', first_name: 'a', last_name: 'b', address: 'test')
    tea = Tea.create!(name: 'a')
    Subscription.create!(subscription_id: SecureRandom.hex, monthly_fee: 3.25, status: 1, frequency: 1, tea: tea, customer: customer)
    it { should validate_uniqueness_of(:subscription_id) }
    it { should validate_presence_of(:subscription_id) }
    it { should validate_presence_of(:monthly_fee) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
  end
end