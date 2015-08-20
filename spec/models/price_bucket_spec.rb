require 'rails_helper'

describe PriceBucket do
  it {should_not allow_value(-1).for(:number_users)}
  it {should validate_presence_of(:company_id)}
end

RSpec.describe PriceBucket, type: :model do
  it "should have a default price and number of users" do
    company = Company.create(name: 'Ikea')
    pricing_bucket = PriceBucket.create(company_id: company.id)
    expect(pricing_bucket.number_users).to eq(0)
    expect(pricing_bucket.price).to eq(10)
  end
end
