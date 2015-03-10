class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :share_to

      t.timestamps null: false
    end
  end
end
