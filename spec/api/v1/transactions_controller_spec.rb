require 'rails_helper'

RSpec.describe "Api::V1::TransactionsController" do
  it 'can create a transaction' do
    proposed_transaction_params = {
      "companyName" => "EAT24",
      "totalMonthlyActiveUsers" => 1000,
      "pricingBuckets"=> [ { numUsers: 0, price: 20}, { numUsers: 1000, price: 10} ]
    }

    post '/api/v1/transactions', format: :json, trade: proposed_transaction_params

    expect(response.status).to be(201)
    expect(JSON.parse(response.body)).to be({ charge: 110000, result: "success", message: null })
  end
end
