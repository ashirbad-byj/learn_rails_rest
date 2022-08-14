class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :id, numericality: true, inclusion: {in: 0..9999999999999,message: "needs greater than 0, smaller than 9999999999999"}, allow_nil: true
  validates :quantity, numericality: true, inclusion: {in: 0..999999,message: "needs greater than 0, smaller than 999999"}, presence: true
  validates :status, numericality: true, inclusion: {in: 0..2, message: "needs to be 0, 1 or 2"}
end
