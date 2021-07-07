class Folders < ActiveRecord::Base
  attr_accessible :folder_id, :folder_name, :user_id, :is_deleted

  validates :folder_id, numericality: true, :uniqueness => true
  validates :folder_name, length: { minimum: 3 }
  validates :user_id, numericality: true

  belongs_to :users, foreign_key: :user_id, :select => [:user_first_name]

  has_many :notes

  validate :save_object?

  default_scope { where(is_deleted: 0) }

  def validate_associations?
    true
  end

  after_find do |folder|
    puts "The object has been found!"
    puts folder.inspect

  end

  def save_object?
    users = Users.where(user_id: user_id, is_deleted: 0).first
    if users.nil?
      errors[:user_id] << "user_id not found"
      return false
    end
  end
end
