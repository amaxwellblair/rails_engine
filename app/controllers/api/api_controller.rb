module Api
  class ApiController < ApplicationController
    include ApiHelpers
    respond_to :json
    protect_from_forgery with: :null_session

    def index
      respond_with model.all
    end

    def show
      respond_with model.find(params[:id])
    end

    def find
      column = parse_attributes
      if column
        if model.columns_hash[column].type == :string
          respond_with model.where("lower(#{column}) = ?", params[column].downcase).first
        else
          respond_with model.find_by(column => params[column])
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
  end
end
