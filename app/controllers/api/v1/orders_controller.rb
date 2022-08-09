class Api::V1::OrdersController < ApplicationController
    def getOrders
        @params = {status: 1}
        request.query_parameters.symbolize_keys.each do |param| 
            if param[0] == :id 
                @params[:id] = param[1]
            elsif param[0] == :customer_id
                @params[:customer_id] = param[1]
            elsif param[0] == :item_id
                @params[:item_id] = param[1]
            end
        end
        @orders = Order.where(@params)
        render json: @orders
        #render json: ["Hello World"]
    end

    def addOrder
        Order.create(customer_id: params[:customer_id], item_id: params[:item_id], quantity: params[:quantity])
        render json: {message: "Success"}
    end

    def deleteOrder
        @ord = Order.find_by(id: params[:id])
        @ord.update(status: 0)
        render json: {message: "Success"}
    end
    def editOrder
        ord = Order.find_by(id: params[:id],status: 1)
        #p params[:data].to_unsafe_h.symbolize_keys
        @update_data = {}
        params[:data].to_unsafe_h.symbolize_keys.each do |param|
            case param[0] 
                when :id  
                  @update_data[:id] = param[1]
                when :customer_id
                  @update_data[:customer_id] = param[1]
                when :item_id
                  @update_data[:item_id] = param[1]
                when :quantity
                    @update_data[:quantity] = param[1]
                when :status
                  @update_data[:status] = param[1]
                else
                end
        end
        if @update_data.length > 0
            ord.update(@update_data)
        end
        render json: {message: "Success"}
    end
end
