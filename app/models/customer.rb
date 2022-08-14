class Customer < ApplicationRecord
    has_many :orders
    has_many :items, through: :orders
    validates :name, format: { with: /\A[a-z A-Z]+\z/}, presence: true,length: { minimum: 2, maximum: 15 }
    validates :id, numericality: true, inclusion: {in: 0..99999999999,message: "needs greater than 0, smaller than 99999999999"}, presence: true
    validates :age, numericality: true, inclusion: {in: 0..200,message: "should lie in 0 to 200"}, presence: true
    validates :status, numericality: true, inclusion: {in: 0..2,message: "should be 0, 1 or 2"}, presence: true
end
