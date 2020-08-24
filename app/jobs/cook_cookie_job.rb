class CookCookieJob < ActiveJob::Base

  def perform(cookie_id)
    cookie = Cookie.find(cookie_id)
    CookCookie.new.call(cookie) if !cookie.ready?
  end

end