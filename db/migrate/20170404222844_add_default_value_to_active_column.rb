class AddDefaultValueToActiveColumn < ActiveRecord::Migration[5.0]
  def change
    change_column_default :friendships, :accepted, from: true, to: false
  end
end
