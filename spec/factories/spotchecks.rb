FactoryGirl.define do
  factory :spotcheck do
    association :checker, factory: :user
    sequence(:title) {|n| "spotcheck-#{n}"}

  end
end
