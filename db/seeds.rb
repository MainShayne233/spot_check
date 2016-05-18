# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create email: 'foo@bar.com', password: 'password', first_name: 'simon', last_name: 'monis'
puts 'CREATED ADMIN USER: ' << user.email

# Creates 4 sample assignees
assignees = %w(john josh jake joseph).map {|name| User.create(email: "#{name}@seed.com",
                                                              password: 'password',
                                                              first_name: "#{name}",
                                                              last_name: "#{name.reverse}")}.to_a

# Creates a spotcheck
spotcheck = user.spotchecks.create(title: "Support SW")

activity_titles = ['DA59804 Dependency Checking Report',
                   'Project Admin',
                   'DA65432 Ingest of simultanious combustion',
                   'DA76544 Fix CSS for CUI show ']

activities = activity_titles.map {|title| user.activities.create title: title}


activities.each {|activity| spotcheck.spots.create(activity_id: activity.id,
                                                   assignee_id: assignees[rand(4)].id,
                                                   hours_worked: rand(40),
                                                   work_accomplished: Faker::Hipster.paragraph)}

