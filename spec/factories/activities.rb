FactoryGirl.define do
  factory :activity do
    title { unique_title }
  end
end

def unique_title
  return '0-activity' unless Activity.count > 0
  "#{Activity.last.title.split('-').first.to_i + 1}-activity"
end