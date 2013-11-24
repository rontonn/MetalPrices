class CreateMetals < ActiveRecord::Migration
  def change
    create_table :metals do |t|
    	t.text :date
      	t.string :name
      	t.string :price

      t.timestamps
    end
  end
end
