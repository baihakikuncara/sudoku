import 'dart:developer';

import 'boards_data.dart';

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

  Board(
      {String data =
          '879132564213465897546798231987241653635879142124356978351624789798513426462987315',
      Difficulty dif = Difficulty.none}) {
    log('Board::Board(data:$data, dif:$dif)');
    board = List.generate(
        boardSize,
        (row) => List.generate(
            boardSize, (column) => int.parse(data[row * boardSize + column])));
    setDifficulty(dif);
    _boardOrigin = toString();
  }

  bool setValue({required int value, required int row, required int col}) {
    if (_boardOrigin[row * boardSize + col] == "0") return false;
    board[row][col] = value;
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
