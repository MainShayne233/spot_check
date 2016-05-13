# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

# Creates 4 sample users
%w(john josh jake joseph).each {|name| User.create email: "#{name}@seed.com", passowrd: 'password'}

# Creates a spotcheck
spotcheck = user.spotchecks.create(title: "Support SW")
#
# ['DA59804 Dependency Checking Report',
#  'Project Admin',
#  'DA65432 Ingest of simultanious combustion',
#  'DA76544 Fix CSS for CUI show ']. each {|a| }