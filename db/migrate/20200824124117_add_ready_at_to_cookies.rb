class AddReadyAtToCookies < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :ready_at, :datetime
  end
end
