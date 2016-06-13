@javascript

Feature: Edit Spots

  Background:
    Given I am a user
    Given I am logged in


  Scenario: Assignee edits a spotcheck
    Given I am assigned a spot
    And I set the current spot the "last" assigned to me
    And I navigate to the spotcheck of that spot
    When I edit the "hours worked" of the spot
    Then the spot's "hours worked" should be persisted
    When I edit the "work accomplished" of the spot
    Then the spot's "work accomplished" should be persisted
    And I should not be able to edit the spot's "hours left"