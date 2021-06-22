class CreateFolders < ActiveRecord::Migration
  def up
    create_table :folders do |t|
      t.column "folder_id", "BIGINT UNSIGNED", :null=>false
      t.string :folder_name, :null=>false
      t.boolean :is_deleted, :null=>false, :default=>0
      t.references :user, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end
    add_index :folders, :folder_id
  end
  def down
    remove_index :folders, :folder_id
    drop_table :folders
  end
end
