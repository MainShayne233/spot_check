Feature: Log in

  Scenario: User logs in
    Given I am a user
    And I log in
    Then I should be logged in
