class CreatePixels < ActiveRecord::Migration[5.2]
  def change
    create_table :pixels do |t|
      t.string :color
      t.integer :user_id
      t.integer :x
      t.integer :y
      t.timestamps
    end
  end
end
