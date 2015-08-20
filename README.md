#README: Challenge Two, Transaction API

##Deployed API
https://transactionapi.herokuapp.com/

Example API Call:

transaction_params = {
  "companyName" => "EAT24",
  "totalMonthlyActiveUsers" => 10000,
  "pricingBuckets"=> [ { numUsers: 0, price: 20}, { numUsers: 1000, price: 10} ]
}

post 'https://transactionapi.herokuapp.com/api/v1/transactions.json', transaction_params

##How to get running locally?

Configuration: 1. 'bundle install'

Database creation: 1. 'rake db:create'  2. 'rake db:migrate'

How to run the test suite: 1. 'rspec'
