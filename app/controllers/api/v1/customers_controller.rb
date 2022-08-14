class Api::V1::CustomersController < ApplicationController

    before_action :validate_params_customer
    
    def getCustomers
        @customers = Customer.where(status: 1)
        render json: @customers
        #render json: ["Hello World"]
    end

    def getCustomerWithId
        #render json: [params[:id]]
        @customer = Customer.find_by!(id:params[:id], status:1)
        render json: [@customer]
    end
    def addCustomer
        Customer.create!(id: params[:id],name: params[:name], age: params[:age])
        render json: {message: "Success"}
    end

    def deleteCustomer
        cust = Customer.find_by!(id: params[:id])
        cust.update!(status: 0)
        render json: {message: "Success"}
    end
    def editCustomer
        cust = Customer.find_by!(id: params[:id], status: 1)
        #p params[:data].to_unsafe_h.symbolize_keys

        @update_data = {}
        params[:data].to_unsafe_h.symbolize_keys.each do |param|
            case param[0] 
                when :id  
                  @update_data[:id] = param[1]
                when :name
                  @update_data[:name] = param[1]
                when :age
                  @update_data[:age] = param[1]
                when :status
                  @update_data[:status] = param[1]
                else
                end
        end
        if @update_data.length > 0
            cust.update!(@update_data)
        end

        render json: {message: "Success"}
    end
end
