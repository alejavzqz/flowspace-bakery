class CookCookie

  def call(cookie)
    cookie.update(ready_at: DateTime.current)
  end

end