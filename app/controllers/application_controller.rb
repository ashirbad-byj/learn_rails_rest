require_relative "validations/item_validations.rb"
require_relative "validations/customer_validations.rb"

class ApplicationController < ActionController::API
    
    #rescue_from ActiveRecord::RecordNotUnique, with: :not_unique
    rescue_from ActiveRecord::ActiveRecordError, with: :active_record_error
    #rescue_from StandardError, with: :std_error


    def validate_params_customer
        case params[:action] 
        when "getCustomers"
            @validator = GETCustomersValidation.new(params)
        when "getCustomerWithId"
            @validator = GETCustomerIDValidation.new(params)
        when "addCustomer"
            @validator = POSTCustomerValidation.new(params)
        when "deleteCustomer"
            @validator = DELETECustomerValidation.new(params)
        when "editCustomer"
            @validator = PATCHCustomerValidation.new(params)
        else
        end

        if !@validator.valid?
            render json: { error: @validator.errors }
        end
    end

    def validate_params_item
        case params[:action] 
        when "getItems"
            @validator = GETItemsValidation.new(params)
        when "getItemWithId"
            @validator = GETItemIDValidation.new(params)
        when "addItem"
            @validator = POSTItemValidation.new(params)
        when "deleteItem"
            @validator = DELETEItemValidation.new(params)
        when "editItem"
            @validator = PATCHItemValidation.new(params)
        else
        end

        if !@validator.valid?
            render json: { error: @validator.errors }
        end
    end

    private 
    def active_record_error(_e)
        if _e.is_a?ActiveRecord::RecordNotFound
            render json: {error: "Corrosponding record does not exist!", type: "DB error"}, status: :not_found
        elsif  _e.is_a?ActiveRecord::RecordNotUnique
            render json: {error: "Corrosponding ID already exist!", type: "DB error"}, status: :conflict

        else
            render json: {error: _e.message, type: "DB error"}, status: :not_acceptable
        end
    end
    def std_error(_e)
        render json: {error: _e, type: "STD error"}
    end
end
