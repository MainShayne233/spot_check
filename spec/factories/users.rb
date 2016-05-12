FactoryGirl.define do
  factory :user do
    name 'Test User'
    email {unique_email}
    password 'password'

    trait :admin do
      role 'admin'
    end

  end
end


def unique_email
  return '0@test.com' unless User.count > 0
  "#{User.last.email.split('@').first.to_i + 1}@example.com"
end