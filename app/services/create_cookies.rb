class CreateCookies
  DEFAULT_COOKIE_AMOUNT = 1

  def call(oven, params)
    amount = amount_of_cookies(params[:amount])

    amount.times do
      cookie = oven.cookies.create!(fillings: params[:fillings])
      CookCookieJob.perform_later(cookie.id)
    end
  end

  private

    def amount_of_cookies(value)
      integer_value = value.to_i
      if integer_value > 0
        integer_value
      else
        DEFAULT_COOKIE_AMOUNT
      end 
    end

end