Feature: Board
  As a user
  I be able to make a move
  So I can update the board

  Scenario: User makes a move
    When I am prompted to make a move
    Then I should be able to enter an integer
    And I should be able to see the updated board