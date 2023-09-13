require 'rails_helper'

RSpec.describe 'cancel existing subscription' do
  describe 'delete request to cancel existing subscription' do
    it 'cancels an existing subscription' do
      Subscription.destroy_all
      Customer.destroy_all
      Tea.destroy_all

      customer = Customer.create!(email: 'austin@gmail.com', first_name: 'Austin', last_name: 'Woods', address: 'test')
      tea = Tea.create!(name: 'Oolong')
      sub_id = SecureRandom.hex
      sub = Subscription.create!(subscription_id: sub_id, monthly_fee: 3.25, status: 1, frequency: 1, tea: tea, customer: customer)

      expect(customer.subscriptions.count).to eq(1)
      expect(tea.subscriptions.count).to eq(1)
      expect(sub.status).to eq("active")

      subscription_params = {
        subscription_id: sub_id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      delete '/api/v1/subscribe', headers:, params: JSON.generate(subscription_params)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      
      expect(customer.subscriptions.count).to eq(1)
      expect(tea.subscriptions.count).to eq(1)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to have_key(:subscription_id)
      expect(json_response[:data][:attributes][:monthly_fee]).to eq(3.25)
      expect(json_response[:data][:attributes][:status]).to eq("cancelled")
      expect(json_response[:data][:attributes][:frequency]).to eq('bi_weekly')
      expect(json_response[:data][:attributes][:tea]).to eq("Oolong")
      expect(json_response[:data][:attributes][:customer]).to eq('austin@gmail.com')
    end
  end
end