class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.column "user_id", "BIGINT UNSIGNED",:null=>false
      t.string :user_first_name
      t.string :user_last_name
      t.string :user_role
      t.string :user_password
      t.boolean :is_login_enabled, :null=>false, :default=>0
      t.boolean :is_deleted, :null=>false, :default=>0
      t.timestamps
    end
    add_index :users, :user_id
  end

  def down
    remove_index :users, :user_id
    drop_table :users
  end
end
