FactoryGirl.define do
  factory :spotcheck do
    association :checker, factory: :user
    title {unique_title}
  end
end

def unique_title
  return '0-spotcheck' unless Spotcheck.count > 0
  "#{Spotcheck.last.title.split('-').first.to_i + 1}-spotcheck"
end