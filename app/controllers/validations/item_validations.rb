class GETItemIDValidation
    include ActiveModel::Validations
    attr_accessor :id
    validates :id, numericality: true, inclusion: {in: 0..9999999999999}
    def initialize(params={})
        @id = params[:id].to_i
    end
end
class GETItemsValidation
    include ActiveModel::Validations
    def initialize(params={})
    end
end

class POSTItemValidation
    include ActiveModel::Validations
    attr_accessor :name, :id, :status, :price
    validates :name, format: { with: /\A[a-z _\-A-Z0-9]+\z/}
    validates :id, numericality: true, inclusion: {in: 0..9999999999999}
    validates :price, numericality: true, inclusion: {in: 0..9999999999999}

    def initialize(params={})
        @name = params[:name]
        @id = params[:id]
        @price = params[:price]
    end
end

class DELETEItemValidation
    include ActiveModel::Validations
    attr_accessor :id
    validates :id, numericality: true, inclusion: {in: 0..9999999999999}
    def initialize(params={})
        @id = params[:id]
    end
end

class PATCHItemValidation
    include ActiveModel::Validations
    attr_accessor :id
    validates :id, numericality: true, inclusion: {in: 0..9999999999999}
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
                    if !(param[1].is_a?Integer) || !(param[1] in 0..9999999999999)
                        errors.add(:id_new, 'New Item ID not valid')
                    end
                when :name
                    if !(param[1].is_a?String) || !(/\A[a-z _\-A-Z0-9]+\z/.match?param[1])
                        errors.add(:name, 'Name not valid')
                    end
                when :price
                    if !(param[1].is_a?Integer) || !(param[1] in 0..9999999999999)
                        errors.add(:price, 'price not valid')
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