Feature: Board
  As a user
  I want be able to see the board
  So I know where I can make a move

  Scenario: User sees the board
    When I start the game
    Then I should see the empty board
    And I should be prompted to make a move
