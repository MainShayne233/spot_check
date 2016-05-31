Then(/^I should be logged in$/) do
  visit '/'
  expect(page).to_not have_content 'Sign in'
end

Given(/^I am logged in$/) do
  step 'I log in'
end
