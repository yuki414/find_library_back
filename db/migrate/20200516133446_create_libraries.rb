class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :systemid
      t.integer :libid
      t.float :latitude
      t.float :longitude
      t.string :category
      t.string :libkey

      t.timestamps
    end
  end
end
