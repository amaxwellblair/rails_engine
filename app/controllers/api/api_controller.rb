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
      return respond_with_column_error unless column
      if model.columns_hash[column].type == :string
        respond_with model.where("lower(#{column}) = ?", params[column].downcase).first
      else
        respond_with model.where(column => params[column]).first
      end
    end

    def find_all
      column = parse_attributes
      return respond_with_column_error unless column
      if model.columns_hash[column].type == :string
        respond_with model.where("lower(#{column}) = ?", params[column].downcase)
      else
        respond_with model.where(column => params[column])
      end
    end

    def random
      respond_with model.order("RANDOM()").take
    end

    def relation
      element = model.where(id: params[:id]).take
      relationship = parse_relations
      return respond_with_relation_error unless element.respond_to?(relationship)
      respond_with element.send(parse_relations)
    end
  end
end
