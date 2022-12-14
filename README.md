# Mastermind
A terminal game that simulates the game Master Mind

![Screenshot of player breaking a computer generated code](/images/codebreaker_screenshot.png)

## Features
  - User can play as code breaker or code maker
  - Computer is the opposite player (code breaker or maker)
  - All input (except the player name) is validated
  - User can ask for help at any time
  - User can exit the game at any time

## Rules list
  This is displayed to the user before they play the game
  ```
  Please visit the Mastermind Wikipedia page for general rules on how to play.
  For this specific game, here is what you need to know about how to play:
   - Codes can contain multiple of the same color peg.
   - No blank pegs.
   - Black pegs for correct code pegs in the right position.
   - White pegs for correct code pegs in the wrong position.
   - The codebreaker must put the right code pegs in the right positions to win. 
   - The key pegs don't have to match the position of the code peg they're referencing.
  And here is some general stuff to keep in mind: 
   - Code peg colors must be spelled correctly to be entered.
   - Type "exit" at any time to exit the game.
   - Type "help" at any time to print this message again.
  Finally, here are the possible code colors for the game:
  -------------------------------------------------
  | Blue | Green | Yellow | Red | Orange | Purple |
  -------------------------------------------------
  ```
## How I would improve this program
  - Ask the user if they would like to play again
  - Set up ability to play multiple games, and keep track of each players points
  - Allow 2 players instead of just one and the computer
  - Set up some customization options for the game, such as:
    - Choosing the number of guesses the codebreaker can make
    - Choosing whether blanks or duplicates can be allowed in the hidden code
    - Letting the player choose the possible names/colors for the pegs
