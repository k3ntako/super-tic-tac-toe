Feature: Move
  As a user
  I want to be able to enter a move and see the board update
  So I can make a move

  Scenario: User makes a move to update board
    When I am prompted to make a move
    Then I should be able to enter an integer
    And I should be able to see the updated board
