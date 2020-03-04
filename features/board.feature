Feature: Board
  As a user
  I want to see the board along when instructions when I first start the game
  So I can see where and how I can make a move

  Scenario: User sees the empty board with instructions
    When the game starts
    Then I should see the empty board
    And I should be prompted to make a move
