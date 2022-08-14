class Item < ApplicationRecord
    has_many :orders
    has_many :customers, through: :orders
    validates :name, format: { with: /\A[a-z _\-A-Z0-9]+\z/}, presence: true,length: { minimum: 2, maximum: 15 }
    validates :id, numericality: true, inclusion: {in: 0..9999999999999,message: "needs greater than 0, smaller than 9999999999999"}, presence: true
    validates :price, numericality: true, inclusion: {in: 0..9999999999999,message: "needs greater than 0, smaller than 9999999999999"}, presence: true
    validates :status, numericality: true, inclusion: {in: 0..2,message: "needs to be 0, 1 or 2"}, presence: true
end
