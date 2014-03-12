class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :avatar
      t.string :name
      t.text :bio

      t.timestamps
    end
  end
end
