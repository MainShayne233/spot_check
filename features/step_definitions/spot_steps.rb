Given(/^I am assigned a spot$/) do
  FactoryGirl.create(:spot, assignee: @user)
end

Given(/^I set the current spot the "([^"]*)" assigned to me$/) do |index|
  index = @user.spots.count-1 if index == 'last'
  @spot = @user.spots.to_a[index.to_i]
end

Given(/^I navigate to the spotcheck of that spot$/) do
  visit '/'
  click_on @spot.spotcheck.title
end

When(/^I edit the "([^"]*)" of the spot$/) do |attr|
  user_spots = "#assignee_#{@spot.assignee.id}"
  within(user_spots) do
    within (".#{@spot.title.gsub(' ', '.')}") do
      if ['hours worked', 'hours left'].include? attr
       @new_val = @spot.send(attr.gsub(' ', '_')) + 1
       find(".#{attr.gsub(' ', '_')}").set(@new_val)
      end
    end
  end
end

Then(/^the spot's "([^"]*)" should be persisted$/) do |attr|
  sleep 1
  @spot = Spot.find(@spot.id)
  expect(@spot.send(attr.gsub(' ', '_'))).to eq @new_val
end

Then(/^I should not be able to edit the spot's "([^"]*)"$/) do |attr|
  user_spots = "#assignee_#{@spot.assignee.id}"
  within(user_spots) do
    within (".#{@spot.title.gsub(' ', '.')}") do
      expect(page).to_not have_css("input.#{attr.gsub(' ', '.')}")
    end
  end
end

