FactoryGirl.define do
  factory :spot do
    activity
    spotcheck
    association :assignee, factory: :user
  end
end
