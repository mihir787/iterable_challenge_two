class Company < ActiveRecord::Base
  has_many :transactions
  has_many :price_buckets
  validates :name, presence: true, uniqueness: true
end
