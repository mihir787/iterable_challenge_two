class Api::V1::TransactionsController < ApplicationController

  def create
    if params[:totalMonthlyActiveUsers].to_i >= 0
      company = Company.find_or_create_by(name: params[:companyName])
      PriceBucket.delete_old_buckets(company)
      params[:pricingBuckets].each do |bucket|
        PriceBucket.create(price: bucket[:price], number_users: bucket[:numUsers], company_id: company.id)
      end
      charge = Transaction.calculate_charge(company, params[:totalMonthlyActiveUsers])
      @transactions = Transaction.create(charge: charge, result: 1, company_id: company.id, total_monthly_active_users: params[:totalMonthlyActiveUsers])
      render json: @transactions.format_json, message: nil
    else
      render json: { charge: 0, result: "error", message: "invalid number of users" }
    end

  end

end
