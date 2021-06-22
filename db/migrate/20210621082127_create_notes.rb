class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.column "note_id", "BIGINT UNSIGNED", :null=>false
      t.string :notes_title, :null=>false
      t.string :notes_description, :null=>false
      t.boolean :is_deleted, :null=>false, :default=>0
      t.references :folder, foreign_key: { to_table: :folders }, index: true
      t.references :user, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end
    add_index :notes, :note_id
  end
  def down
    remove_index :notes, :note_id
    drop_table :notes
  end
end
