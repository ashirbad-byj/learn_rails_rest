class Api::V1::ItemsController < ApplicationController

    before_action :validate_params_item

    def getItems
        @items = Item.where(status: 1)
        render json: @items
        #render json: ["Hello World"]
    end

    def getItemWithId
        #render json: [params[:id]]
        @item = Item.find_by!(id: params[:id], status: 1)
        render json: [@item]
    end

    def addItem
        Item.create!(id: params[:id],name: params[:name], price: params[:price])
        render json: {message: "Success"}
    end

    def deleteItem
        @itm = Item.find_by!(id: params[:id])
        @itm.update!(status: 0)
        render json: {message: "Success"}
    end
    def editItem
        itm = Item.find_by!(id: params[:id],status: 1)
        #p params[:data].to_unsafe_h.symbolize_keys
        @update_data = {}

        params[:data].to_unsafe_h.symbolize_keys.each do |param|
            case param[0] 
                when :id  
                  @update_data[:id] = param[1]
                when :name
                  @update_data[:name] = param[1]
                when :price
                  @update_data[:price] = param[1]
                when :status
                  @update_data[:status] = param[1]
                else
                end
        end
        if @update_data.length > 0
            itm.update!(@update_data)
        end

        render json: {message: "Success"}
    end
end
