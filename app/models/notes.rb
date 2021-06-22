class Notes < ActiveRecord::Base
  attr_accessible :note_id, :notes_title, :notes_description, :folder_id, :user_id, :is_deleted

  validates :note_id, numericality: true
  validates :notes_title, length: { minimum: 3 }
  validates :folder_id, numericality: true
  validates :user_id, numericality: true
end
