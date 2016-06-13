FactoryGirl.define do
  factory :activity do
    association :creator, factory: :user
    sequence(:title) {|n| "activity-#{n}"}
  end
end