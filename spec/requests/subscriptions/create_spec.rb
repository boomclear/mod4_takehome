RSpec.describe 'create new subscription' do
  describe 'Post request to create new subscription' do
    it 'creates a subscription instance if a json payload is posted to the api' do
      Subscription.destroy_all
      Customer.destroy_all
      Tea.destroy_all

      customer = Customer.create!(email: 'austin@gmail.com', first_name: 'Austin', last_name: 'Woods', address: 'test')
      tea = Tea.create!(name: 'Oolong')

      expect(customer.subscriptions.count).to eq(0)
      expect(tea.subscriptions.count).to eq(0)
      subscription_params = {
        tea_name: 'Oolong',
        email: 'austin@gmail.com',
        monthly_fee: 12.99,
        frequency: 'monthly'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/subscribe', headers:, params: JSON.generate(subscription_params)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      
      expect(customer.subscriptions.count).to eq(1)
      expect(tea.subscriptions.count).to eq(1)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to have_key(:subscription_id)
      expect(json_response[:data][:attributes][:monthly_fee]).to eq(12.99)
      expect(json_response[:data][:attributes][:status]).to eq("active")
      expect(json_response[:data][:attributes][:frequency]).to eq('monthly')
      expect(json_response[:data][:attributes][:tea]).to eq("Oolong")
      expect(json_response[:data][:attributes][:customer]).to eq('austin@gmail.com')
    end
  end
end
