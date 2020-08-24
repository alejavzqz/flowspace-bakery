module Api
  class OvensController < ApplicationController
    before_action :authenticate_user!

    def show
      @oven = Oven.find(params[:id])
      render json: @oven.attributes
    end
  
  end
end