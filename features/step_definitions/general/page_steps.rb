Then(/^I should see the "([^"]*)"$/) do |object|
  expect(page).to have_content(label(object))
end

def label(object)
  return object.title if ['Spotcheck', 'Activity', 'Spot'].include? object.class.to_s
end
