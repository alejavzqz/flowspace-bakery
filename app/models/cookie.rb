class Cookie < ActiveRecord::Base
  attr_accessor :amount

  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true

  def ready?
    !!ready_at
  end
end
