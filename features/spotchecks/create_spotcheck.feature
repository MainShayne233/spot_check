@javascript

Feature: Create spotcheck

  Scenario: User creates spotcheck
    Given I am a user
    And I am logged in
    And I am on the "root" page
    And I click "Create New Spotcheck"
    And I fill in a "Title"
    And I click "Save"
    And I set the current spotcheck to "last"
    Then I should see the "spotcheck"
