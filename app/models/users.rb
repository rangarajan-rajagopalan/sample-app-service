class Users < ActiveRecord::Base
  attr_accessible :user_id, :user_first_name, :user_last_name, :user_password, :user_role, :is_login_enabled, :is_deleted

  validates :user_id, numericality: true
  validates :user_first_name, length: { minimum: 3 }
  validates :user_last_name, length: { maximum: 3 }
  validates :user_password, length: { in: 6..20 }

  # scope :is_deleted, ->{ where.not(is_deleted: true) }
  # default_scope { where(is_deleted = false) }

end
