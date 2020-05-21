class CreateUserAdditions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_additions do |t|
      t.integer :uid
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
