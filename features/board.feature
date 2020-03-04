Feature: Board
  As a user
  I want to see the board when I first the game
  So I can see where I can make a move

  Scenario: User sees the empty board
    When the game starts
    Then I should see the empty board
    And I should be prompted to make a move