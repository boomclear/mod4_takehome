require 'rails_helper'

RSpec.describe 'cancel existing subscription' do
  describe 'delete request to cancel existing subscription' do
    it 'cancels an existing subscription' do
      Subscription.destroy_all
      Customer.destroy_all
      Tea.destroy_all

      customer = Customer.create!(email: 'austin@gmail.com', first_name: 'Austin', last_name: 'Woods', address: 'test')
      tea = Tea.create!(name: 'Oolong')
      sub = Subscription.create!(subscription_id: SecureRandom.hex, monthly_fee: 3.25, status: 1, frequency: 1, tea:,
                                 customer:)
      sub2 = Subscription.create!(subscription_id: SecureRandom.hex, monthly_fee: 3.25, status: 1, frequency: 1, tea:,
                                  customer:)
      sub3 = Subscription.create!(subscription_id: SecureRandom.hex, monthly_fee: 3.25, status: 1, frequency: 1, tea:,
                                  customer:)

      expect(customer.subscriptions.count).to eq(3)
      expect(tea.subscriptions.count).to eq(3)
      expect(sub.status).to eq('active')

      subscription_params = {
        email: "austin@gmail.com"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/subscriptions', headers:, params: JSON.generate(subscription_params)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(json_response[:data].count).to eq(3)
      expect(json_response).to have_key(:data)
      json_response[:data].each do |json|
        expect(json[:attributes]).to have_key(:subscription_id)
        expect(json[:attributes][:monthly_fee]).to eq(3.25)
        expect(json[:attributes][:status]).to eq('active')
        expect(json[:attributes][:frequency]).to eq('bi_weekly')
        expect(json[:attributes][:tea]).to eq('Oolong')
        expect(json[:attributes][:customer]).to eq('austin@gmail.com')
      end
    end
  end
end
