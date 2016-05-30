# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
checker = User.create email: 'foo@bar.com', password: 'password', first_name: 'simon', last_name: 'monis'

# Creates 4 sample assignees
assignees = (1..10).map{Faker::Name.name}.uniq.map{|name| User.create(email: "#{name.gsub(' ', '')}@seed.com",
                                                                       password: 'password',
                                                                       first_name: name.split(' ')[0],
                                                                       last_name: name.split(' ')[1])}


# Creates a spotcheck

spotchecks = ['Support SW', 'Build Ops', 'Gateway'].map{|title| checker.spotchecks.create(title: title)}

activities = ['DA59804 Dependency Checking Report',
              'Project Admin',
              'DA65432 Ingest of simultanious combustion',
              'DA76544 Fix CSS for CUI show '].map {|title| checker.activities.create title: title, hours_left: rand(100) + 50}

spotchecks.each do |spotcheck|
  assignees.each do |assignee|
    rand(3).times do
      spotcheck.spots.create(assignee_id: assignee.id,
                             activity_id: activities[rand(3)].id,
                             hours_worked: rand(40),
                             work_accomplished: Faker::Lorem.paragraph)
    end
  end
end

other_spotcheck = assignees[rand(10)].spotchecks.create(title: 'Executive Administrative tasks')

other_activities = ['Analysis of DA52344',
                    'Documentation for analysis',
                    'Get to mars',
                    'Rewrite CSS'].map {|title| checker.activities.create title: title, hours_left: rand(100) + 50}

other_activities.each do |activity|
  (assignees << checker). each do |assignee|
    other_spotcheck.spots.create(assignee_id: assignee.id,
                                 activity_id: activity.id,
                                 hours_worked: rand(40),
                                 work_accomplished: Faker::Lorem.paragraph)
  end
end
