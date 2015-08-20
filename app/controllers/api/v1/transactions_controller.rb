class Api::V1::TransactionsController < ApplicationController

  def create
    if params[:totalMonthlyActiveUsers].to_i >= 0
      company = Company.find_or_create_by(name: params[:companyName])
      PriceBucket.delete_old_buckets(company)
      create_price_buckets(company, params)
      transactions = Transaction.create(charge: calculate_charge(company, params[:totalMonthlyActiveUsers]), result: 1, company_id: company.id, total_monthly_active_users: params[:totalMonthlyActiveUsers])
      render json: transactions.format_json, message: nil
    else
      render json: { charge: 0, result: "error", message: "invalid number of users" }
    end
  end

  private

  def calculate_charge(company, totalMonthlyActiveUsers)
    Transaction.calculate_charge(company, totalMonthlyActiveUsers)
  end

  def create_price_buckets(company, params)
    params[:pricingBuckets].each do |bucket|
      if bucket[:price].empty? || bucket[:price].nil?
        PriceBucket.create(number_users: bucket[:numUsers], company_id: company.id)
      else
        PriceBucket.create(price: bucket[:price], number_users: bucket[:numUsers], company_id: company.id)
      end
    end
  end
end
