FactoryGirl.define do
  factory :preference, class: 'Preferences' do
    user_id 1
    show_all_spots false
  end
end
