require 'rails_helper'

RSpec.describe "Api::V1::TransactionsController" do
  it 'can create a transaction with one bucket' do
    transaction_params = {
      "companyName" =>  "EAT24",
      "totalMonthlyActiveUsers" =>  10000,
      "pricingBuckets"=>  [ { numUsers:  0, price:  10} ]
    }

    post '/api/v1/transactions.json', transaction_params

    expect(JSON.parse(response.body)).to eq({"charge"=> 100000, "result" => "success", "message"=> nil})

    expect(Company.first.name).to eq("EAT24")
    expect(Transaction.first.charge).to eq(100000)
  end

  it 'can create a transaction with two buckets' do
    transaction_params = {
      "companyName" =>  "Cheese",
      "totalMonthlyActiveUsers" =>  10000,
      "pricingBuckets"=>  [ { numUsers:  0, price:  20}, { numUsers:  1000, price:  10} ]
    }

    post '/api/v1/transactions.json', transaction_params

    expect(JSON.parse(response.body)).to eq({ "charge"=>  110000, "result" => "success", "message" =>  nil })

    expect(Company.first.name).to eq("Cheese")
    expect(Transaction.first.charge).to eq(110000)
  end

  it 'can create a transaciton with three buckets' do
    transaction_params = {
      "companyName" =>  "Burger",
      "totalMonthlyActiveUsers" =>  382983,
      "pricingBuckets"=>  [ { numUsers:  0, price:  20}, { numUsers:  1000, price:  10}, {
      numUsers:  50000, price:  5 } ]
    }

    post '/api/v1/transactions.json', transaction_params
    expect(JSON.parse(response.body)).to eq({"charge"=> 2179915, "result" => "success", "message" => nil})

    expect(Company.first.name).to eq("Burger")
    expect(Transaction.first.charge).to eq(2179915)
  end

  it 'cannot create a transaction with negative users' do
    transaction_params = {
      "companyName" => "EAT24",
      "totalMonthlyActiveUsers" => -1,
      "pricingBuckets"=>  [ { numUsers: 5000, price: 5} ]
    }

    post '/api/v1/transactions.json', transaction_params
    expect(JSON.parse(response.body)).to eq({ "charge" => 0, "result" => "error", "message" => "invalid number of users" })
  end

  it 'has default price when bucket price not specified' do
    transaction_params = {
      "companyName" => "EAT24",
      "totalMonthlyActiveUsers" => 6000,
      "pricingBuckets"=>  [ { numUsers: 5000, price: "" } ]
    }

    post '/api/v1/transactions.json', transaction_params
    expect(JSON.parse(response.body)).to eq({"charge"=>60000, "result" => "success", "message" => nil})
  end
end
