# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create :email => "admin@admin.com", :full_name => "admin", :password => "admin123", :role => "admin"
User.create :email => "test@provider.com", :full_name => "test provider", :password => "test123", :role => "provider"
User.create :email => "test@patient.com", :full_name => "test patient", :password => "test123", :role => "patient"