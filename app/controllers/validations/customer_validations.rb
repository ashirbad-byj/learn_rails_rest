class GETCustomerIDValidation
    include ActiveModel::Validations
    attr_accessor :id
    validates :id, numericality: true, inclusion: {in: 0..99999999999}
    def initialize(params={})
        @id = params[:id].to_i
    end
end
class GETCustomersValidation
    include ActiveModel::Validations
    def initialize(params={})
    end
end

class POSTCustomerValidation
    include ActiveModel::Validations
    attr_accessor :name, :id, :status, :age
    validates :name, format: { with: /\A[a-z A-Z]+\z/}
    validates :id, numericality: true, inclusion: {in: 0..99999999999}
    validates :age, numericality: true, inclusion: {in: 0..200}

    def initialize(params={})
        @name = params[:name]
        @id = params[:id]
        @age = params[:age]
    end
end

class DELETECustomerValidation
    include ActiveModel::Validations
    attr_accessor :id
    validates :id, numericality: true, inclusion: {in: 0..99999999999}
    def initialize(params={})
        @id = params[:id]
    end
end

class PATCHCustomerValidation
    include ActiveModel::Validations
    attr_accessor :id
    validates :id, numericality: true, inclusion: {in: 0..99999999999}
    validate :data_check

    def initialize(params={})
        @id = params[:id]
        @data = params[:data]
        if params[:data]
            if params[:data][:id] 
                @id_new = params[:data][:id]
            end
        end
    end

    def data_check
        @data.to_unsafe_h.symbolize_keys.each do |param|
            case param[0] 
                when :id  
                    if !(param[1].is_a?Integer) || !(param[1] in 0..99999999999)
                        errors.add(:id_new, 'New Customer ID not valid')
                    end
                when :name
                    if !(param[1].is_a?String) || !(/\A[a-z A-Z]+\z/.match?param[1])
                        errors.add(:name, 'Name not valid')
                    end
                when :age
                    if !(param[1].is_a?Integer) || !(param[1] in 0..200)
                        errors.add(:age, 'age not valid')
                    end
                when :status
                    if !(param[1].is_a?Integer) || !(param[1] in 0..2)
                        errors.add(:status, 'status id not valid')
                    end
                else
                end
        end
    end
end