# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = Users.new()
user.user_id=800000000
user.user_first_name='Rails'
user.user_last_name='Admin'
user.user_role='Admin'
user.user_password='123'
user.is_login_enabled=true
user.is_deleted=false
user.save
