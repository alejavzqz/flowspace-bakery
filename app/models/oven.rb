class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :cookies, as: :storage

  validates :user, presence: true

  def cookies_ready?
    !cookies.where(ready_at: nil).exists?
  end

  def attributes
    {
      cookies_ready: cookies_ready?
    }.merge(super)
  end

end
