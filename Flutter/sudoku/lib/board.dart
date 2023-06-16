import 'dart:developer';

import 'data_board.dart';

enum Difficulty {
  easy(30),
  medium(40),
  hard(50),
  none(0);

  const Difficulty(this.value);
  final int value;
}

class Board {
  static const int _range = 10;
  static const int boardSize = 9;
  static const int blockSize = 3;

  late final String _boardOrigin;
  List<List<int>> board = [];
  bool isComplete = false;

  Board({String? data, Difficulty? dif}) {
    data ??=
        '879132564213465897546798231987241653635879142124356978351624789798513426462987315';
    dif ??= Difficulty.none;
    log('Board::Board(data:$data, dif:$dif)');
    board = List.generate(
        boardSize,
        (row) => List.generate(
            boardSize, (column) => int.parse(data![row * boardSize + column])));
    setDifficulty(dif);
    _boardOrigin = toString();
  }

  bool setValue({required int value, required int row, required int col}) {
    if (!isEditable(row, col)) return false;
    board[row][col] = value;
    checkComplete();
    return true;
  }

  int getValue({required int row, required int col}) {
    return board[row][col];
  }

  void setDifficulty(Difficulty dif) {
    log('Board:setDifficulty(dif:$dif)');
    int step = 0;
    if (dif != Difficulty.none) {
      step = dif.value + BoardsData().rng.nextInt(_range);
    }

    var row = 0, col = 0;
    while (step > 0) {
      if (BoardsData().rng.nextBool()) {
        do {
          row = BoardsData().rng.nextInt(boardSize);
          col = BoardsData().rng.nextInt(boardSize);
        } while (board[row][col] == 0);
        board[row][col] = 0;
        step--;
      } else {
        do {
          row = BoardsData().rng.nextInt(boardSize);
          col = BoardsData().rng.nextInt(boardSize);
        } while (board[row][col] == 0 || board[col][row] == 0);
        board[row][col] = 0;
        board[col][row] = 0;
        step -= 2;
      }
    }
  }

  bool isEditable(int row, int col) {
    if (isComplete) return false;
    if (_boardOrigin[row * boardSize + col] == "0") return true;
    return false;
  }

  bool haveDuplicate(int row, int col) {
    return haveDuplicateInRow(row, col) ||
        haveDuplicateInCol(row, col) ||
        haveDuplicateInBlock(row, col);
  }

  bool haveDuplicateInRow(int row, int col) {
    for (int c = 0; c < boardSize; c++) {
      if (c == col) continue;
      if (board[row][c] == 0) continue;
      if (board[row][col] == board[row][c]) {
        log('Board:haveDuplicateInRow: val:${board[row][col]}, ($row, $col) and ($row, $c)');
        return true;
      }
    }
    return false;
  }

  bool haveDuplicateInCol(int row, int col) {
    for (int r = 0; r < boardSize; r++) {
      if (r == row) continue;
      if (board[r][col] == 0) continue;
      if (board[row][col] == board[r][col]) {
        log('Board:haveDuplicateInCol: val:${board[row][col]}, ($row, $col) and ($r, $col)');
        return true;
      }
    }
    return false;
  }

  bool haveDuplicateInBlock(int row, int col) {
    int blockRow = (row / blockSize).floor() * blockSize;
    int blockCol = (col / blockSize).floor() * blockSize;
    for (int r = blockRow; r < blockRow + blockSize; r++) {
      for (int c = blockCol; c < blockCol + blockSize; c++) {
        if (r == row && c == col) continue;
        if (board[r][c] == 0) continue;
        if (board[row][col] == board[r][c]) {
          log('Board:haveDuplicateInBlock: val:${board[row][col]}, ($row, $col) and ($r, $c)');
          return true;
        }
      }
    }
    return false;
  }

  void checkComplete() {
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (board[row][col] == 0) return;
        if (haveDuplicate(row, col)) return;
      }
    }
    isComplete = true;
  }

  @override
  String toString() {
    String s = '';
    for (var row in board) {
      for (int col in row) {
        s += '$col';
      }
    }
    log('Board:toString(): $s');
    return s;
  }
}
