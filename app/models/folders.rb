class Folders < ActiveRecord::Base
  attr_accessible :folder_id, :folder_name, :user_id, :is_deleted

  validates :folder_id, numericality: true
  validates :folder_name, length: { minimum: 3 }
  validates :user_id, numericality: true

  default_scope { where(is_deleted: 0) }
end
