module Api
  class ApiController < ApplicationController
    include ApiHelpers
    respond_to :json
    protect_from_forgery with: :null_session

    def index
      respond_with model.all
    end

    def show
      respond_with model.where(id: params[:id]).take
    end

    def find
      column = parse_attributes
      if column
        if model.columns_hash[column].type == :string
          respond_with model.where("lower(#{column}) = ?", params[column].downcase).take
        else
          respond_with model.where(column => params[column]).take
        end
      else
        respond_with({error: "column does not exist"}, status: :not_found)
      end
    end

    def find_all
      column = parse_attributes
      if column
        if model.columns_hash[column].type == :string
          respond_with model.where("lower(#{column}) = ?", params[column].downcase)
        else
          respond_with model.where(column => params[column])
        end
      else
        respond_with({error: "column does not exist"}, status: :not_found)
      end
    end

    def random
      respond_with model.order("RANDOM()").take
    end

    def relation
      element = model.where(id: params[:id]).take
      relationship = parse_relations
      if element.respond_to?(relationship)
        respond_with element.send(parse_relations)
      else
        respond_with({error: "relation does not exist"}, status: :not_found)
      end
    end
  end
end
