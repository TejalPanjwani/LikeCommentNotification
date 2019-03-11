class AddStatutstypeToNotify < ActiveRecord::Migration[5.2]
  def change
    add_column :notifies, :statustype, :integer, default: 0
  end
end
