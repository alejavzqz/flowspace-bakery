module Api
  class CookiesController < ApplicationController
    before_action :authenticate_user!

    def show
      @cookie = Cookie.find(params[:id])
      render json: @cookie.attributes
    end
  
  end
end