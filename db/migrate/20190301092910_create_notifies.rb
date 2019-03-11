class CreateNotifies < ActiveRecord::Migration[5.2]
  def change
    create_table :notifies do |t|
      t.references :user, foreign_key: true
      t.references :notifyable, polymorphic: true

      t.timestamps
    end
  end
end
