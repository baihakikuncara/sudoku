import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sudoku/board.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int row = 0; row < Board.boardSize; row++)
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int col = 0; col < Board.boardSize; col++)
                      SizedBox(
                        width: cellSize,
                        height: cellSize,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child:
                                  Text('${board.getValue(row: row, col: col)}'),
                            )),
                      )
                  ]),
          ],
        ),
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
