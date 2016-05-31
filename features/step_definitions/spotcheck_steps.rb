Given(/^I set the current spotcheck to "([^"]*)"$/) do |index|
  @spotcheck = Spotcheck.last if index == 'last'
end
