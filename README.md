"# sudoku_game_sh" 

A fully interactive Sudoku game written entirely in Bash, complete with:

- Terminal-rendered Sudoku board

- Arrow-key navigation

- Number entry

- Random puzzle generation

- Difficulty levels (1–8)

- Timer

- Solution validator

This project demonstrates how far you can push plain Bash scripting — including cursor control, ANSI colors, and TUI-style input.

🚀 How to Run
- './sudoku.sh' [level]


level (optional):

- Integer from 1 to 8

- Higher level = more empty cells

- Default: 1

Example:

'./sudoku.sh 5'

🎮 Controls
- Key	Action
- Arrow Keys	Move cursor
- 0–9	Enter number (0 clears cell)
- f	Finish and validate the puzzle
- q	Quit game
📁 Project Structure
- sudoku.sh         # Main game script (UI + input handling)
- generate.sh       # Generates randomized Sudoku puzzle
- check.sh          # Validates Sudoku solution

🧠 How It Works

'generate.sh' starts from a solved Sudoku grid, then randomizes it by swapping rows, columns, and digits.

A difficulty level determines how many numbers are removed.

'sudoku.sh' draws the board using ANSI escape codes and tracks cursor position.

'check.sh' verifies rows, columns, and 3×3 blocks for a correct solution.

🔧 Requirements

- A POSIX-compatible shell (bash recommended)

- A terminal that supports arrow-key input and ANSI escape codes

- tput for detecting terminal size

📜 License

Feel free to use, modify, or share.
A credit is appreciated but not required. 😊
