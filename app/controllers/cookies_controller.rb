class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.exists?
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookie = @oven.cookies.new
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    @cookie = @oven.cookies.create!(cookie_params)
    CookCookieJob.perform_later(@cookie.id)
    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end
end
