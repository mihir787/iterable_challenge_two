class Transaction < ActiveRecord::Base
  belongs_to :company

  validates :company_id, presence: true
  validates :result, presence: true
  validates_numericality_of :charge, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :total_monthly_active_users, only_integer: true, greater_than_or_equal_to: 0


  enum result: %w(error success)

  def self.calculate_charge(company, totalMonthlyActiveUsers)
    users_left_to_calculate = totalMonthlyActiveUsers.to_i
    totals = []
    company.price_buckets.each_with_index do |bucket, index|
      if self.users_left_to_calculate_more_than_next_bucket_limit?(company, index, users_left_to_calculate)
        users_left_to_calculate -= company.price_buckets[index + 1].number_users
        totals << self.calculate_charge_for_bucket(company.price_buckets[index + 1].number_users, bucket)
      elsif self.users_left_to_calculate_less_than_next_bucket_limit?(company, index, users_left_to_calculate)
        totals << self.calculate_charge_for_bucket(users_left_to_calculate, bucket)
        users_left_to_calculate = 0
      else
        totals << self.calculate_charge_for_bucket(users_left_to_calculate, bucket)
      end
    end
    totals.reduce(:+)
  end

  def self.calculate_charge_for_bucket(users_left_to_calculate, bucket)
    users_left_to_calculate * bucket.price
  end

  def self.users_left_to_calculate_more_than_next_bucket_limit?(company, index, users_left_to_calculate)
    company.price_buckets[index + 1] != nil && users_left_to_calculate >= company.price_buckets[index + 1].number_users
  end

  def self.users_left_to_calculate_less_than_next_bucket_limit?(company, index, users_left_to_calculate)
    company.price_buckets[index + 1] != nil && users_left_to_calculate >= company.price_buckets[index + 1].number_users
  end

  def format_json
    {"charge" => self.charge, "result" => self.result, "message" => nil}.to_json
  end
end
