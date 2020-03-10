Feature: Move
  As a user
  I want to be able to enter a move and see the board update
  So I can make a move

  Scenario: Human vs. Human
    When I am prompted to make a move
    Then I should be able to enter an integer
    And I should see who made the previous move
    And I should be able to see the updated board
    Then the other player should be prompted to make a move
    And they should be able to enter an integer
    And they should be able to see the updated board

  Scenario: Human vs. Computer
    When the human player has made a move
    Then I should see the board update with the computer move