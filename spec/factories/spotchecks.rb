FactoryGirl.define do
  factory :spotcheck do
    association :checker, factory: :user
  end
end

