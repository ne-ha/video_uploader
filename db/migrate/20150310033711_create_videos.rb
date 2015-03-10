class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :category_id
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
