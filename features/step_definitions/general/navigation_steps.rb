Given(/^I am on the "([^"]*)" page$/) do |page|
  visit send("#{page}_path")
end
