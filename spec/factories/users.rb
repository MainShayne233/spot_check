FactoryGirl.define do
  factory :user, aliases: [:assignee, :creator, :checker] do
    sequence(:first_name) {|n| "first_name_#{n}"}
    sequence(:last_name) {|n| "last_name_#{n}"}
    sequence(:email) {|n| "email-#{n}@test.com"}
    password 'password'

    trait :admin do
      role 'admin'
    end

  end
end
