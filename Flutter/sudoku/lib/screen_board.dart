import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sudoku/board.dart';
import 'package:sudoku/widget_board.dart';

class BoardScreen extends StatelessWidget {
  static const int _margin = 8;
  late final Board board;

  BoardScreen(String data, {Difficulty dif = Difficulty.medium, super.key}) {
    log('BoardScreen(): data: $data dif:$dif');
    if (data.length != Board.boardSize * Board.boardSize) {
      log('BoardScreen: wrong data');
      return;
    }
    board = Board(data: data, dif: dif);
    boardToString();
  }

  @override
  Widget build(BuildContext context) {
    log('BoardScreen:build()');
    int boardLength = math.min(MediaQuery.of(context).size.shortestSide.toInt(),
            MediaQuery.of(context).size.longestSide ~/ 2) -
        _margin * 2;
    double cellSize = (boardLength / Board.boardSize).floorToDouble();

    return Scaffold(
      body: Center(
        child: BoardWidget(board, cellSize),
      ),
    );
  }

  String boardToString() {
    String s = '';
    for (List row in board.board) {
      for (int val in row) {
        s += '$val';
      }
    }
    log('BoardScreen:boardToString(): $s');
    return s;
  }
}
