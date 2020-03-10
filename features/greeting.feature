Feature: Greeting
  As a user
  I want be greeted and shown the board when I start the program
  So I know where I can make a move

  Scenario: User sees the welcome message
    When I start the program
    Then I should see the welcome message
