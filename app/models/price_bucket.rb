class PriceBucket < ActiveRecord::Base
  belongs_to :company

  validates :company_id, presence: true
  validates_numericality_of :number_users, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :price, only_integer: true

  def self.delete_old_buckets(company)
    buckets = PriceBucket.find_by(company_id: company.id)
    buckets.delete_all if !buckets.nil?
  end
end
