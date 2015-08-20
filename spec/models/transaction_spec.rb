require 'rails_helper'

describe Transaction do
  it {should_not allow_value(-1).for(:charge)}
  it {should validate_presence_of(:company_id)}
  it {should validate_presence_of(:result)}
  it {should_not allow_value(-1).for(:total_monthly_active_users)}
end
