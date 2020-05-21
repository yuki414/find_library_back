class CreateLibraryRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :library_relationships do |t|
      t.integer :user_id
      t.integer :library_id

      t.timestamps
    end
    add_index :library_relationships, :user_id
    add_index :library_relationships, :library_id
    add_index :library_relationships, [:user_id, :library_id], unique: true
  end
end
