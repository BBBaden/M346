const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.static('public'));

// Tic Tac Toe Game Logic
let board = Array(9).fill(null);
let currentPlayer = 'X';

function checkWinner() {
  const winPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  for (let pattern of winPatterns) {
    const [a, b, c] = pattern;
    if (board[a] && board[a] === board[b] && board[a] === board[c]) {
      return board[a];
    }
  }

  return board.includes(null) ? null : 'Draw';
}

app.get('/move/:index', (req, res) => {
  const index = req.params.index;

  if (board[index] === null && !checkWinner()) {
    board[index] = currentPlayer;
    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
  }

  res.json({ board, winner: checkWinner() });
});

app.get('/reset', (req, res) => {
  board = Array(9).fill(null);
  currentPlayer = 'X';
  res.json({ board });
});

app.listen(PORT, () => {
  console.log(`Tic Tac Toe app listening at http://localhost:${PORT}`);
});
