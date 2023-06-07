import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/boards_data.dart';

enum Difficulty {
  easy(20),
  medium(30),
  hard(40),
  none(0);

  const Difficulty(this.value);
  final int value;
}

class BoardScreen extends StatelessWidget {
  static const int _range = 10;
  static const int _boardSize = 9;
  List<List> board = [];

  BoardScreen(String data, {Difficulty dif = Difficulty.medium, super.key}) {
    log('BoardScreen(): data: $data dif:$dif');
    board = List.generate(_boardSize, (row) {
      return List.generate(_boardSize, (col) => 0);
    });

    if (data.length != _boardSize * _boardSize) {
      log('BoardScreen: wrong data');
      return;
    }
    var index = 0;
    for (var row = 0; row < _boardSize; row++) {
      for (var col = 0; col < _boardSize; col++) {
        board[row][col] = int.parse(data[index]);
        index++;
      }
    }
    setDifficulty(dif);
    boardToString();
  }

  @override
  Widget build(BuildContext context) {
    log('BoardScreen:build()');
    return Scaffold(
      body: Center(
        child: Text(boardToString()),
      ),
    );
  }

  void setDifficulty(Difficulty dif) {
    int step = 0;
    if (dif != Difficulty.none) {
      step = dif.value + BoardsData().rng.nextInt(_range);
    }

    var row = 0, col = 0;
    while (step > 0) {
      if (BoardsData().rng.nextBool()) {
        do {
          row = BoardsData().rng.nextInt(_boardSize);
          col = BoardsData().rng.nextInt(_boardSize);
        } while (board[row][col] == 0);
        board[row][col] = 0;
        step--;
      } else {
        do {
          row = BoardsData().rng.nextInt(_boardSize);
          col = BoardsData().rng.nextInt(_boardSize);
        } while (board[row][col] == 0 || board[col][row] == 0);
        board[row][col] = 0;
        board[col][row] = 0;
        step -= 2;
      }
    }
    log('BoardScreen:setDifficulty(): dif: $dif, step: $step');
  }

  String boardToString() {
    String s = '';
    for (List row in board) {
      for (int val in row) {
        s += '$val';
      }
    }
    log('BoardScreen:boardToString(): $s');
    return s;
  }
}
