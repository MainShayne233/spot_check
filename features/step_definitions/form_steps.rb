Given(/^I log in$/) do
  visit '/users/sign_in'
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Sign in'
end

Given(/^I fill in a "([^"]*)"$/) do |attr|
  fill_in attr.titleize, with: send("fake_#{attr.downcase}")
end

def fake_title
  "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
end
