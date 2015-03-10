class CreateVidoesUsers < ActiveRecord::Migration
  def change
    create_table :vidoes_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :video, index: true
    end
  end
end
