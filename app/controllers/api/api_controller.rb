module Api
  class ApiController < ApplicationController
    respond_to :json
    protect_from_forgery with: :null_session

    def index
      respond_with model.all
    end

    def show
      respond_with model.find(params[:id])
    end
  end
end
