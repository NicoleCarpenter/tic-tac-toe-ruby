#Tic Tac Toe

Tic-tac-toe is a two player game where each player, one at a time, selects a space on a square board until either there is a winner or there are no remaining spaces, resulting in a tie. A player can win if he or she selects all tiles within a row, column, or diagonal on the board

```ruby
   X | X | X       X |   |         X |   |
  ===+===+===     ===+===+===     ===+===+===
     |   |         X |   |           | X |
  ===+===+===     ===+===+===     ===+===+===
     |   |         X |   |           |   | X
```

##Game Play

The game starts by asking the player's name, and what characters they choose to play with (ie: X, O).

The player can then choose to play either against the computer or another player, or the player can watch a demo of the computer playing itself.

If the player chooses demo mode (3), play will begin automatically after game type selection.

Otherwise, if the player opts to play against the computer, the player will be asked about order preference. Choosing to play against another player will trigger the order preference after the second player's name is received.

Besides in demo mode, each player will be alerted of his or her turn and will be presented with board positions from which to pick.

##Features

- The game may be played with an expanded board. In order to change the board size, the parameter passed into `Board.new` in `game.rb` can be changed. Even if the paramater is not a perfect square, the board will be adjusted to the next size below.

- The game play occurs with a single screen effect by clearing the screen after each move and reprinting the board with the new move in its place.

- Pauses have been added during gameplay to simulate computer decision making.

- Additional messages prompt for new user input for input outside of the parameters of game requests.

##Running the game and tests

The game is a terminal based application using Ruby(2.2.1). Unit testing is accomplished with Rspec.

The game can be played from within the main directory by running the `ruby runner.rb` file. The command `rspec spec/*` will run tests for all classes.



