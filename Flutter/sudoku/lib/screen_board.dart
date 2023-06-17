import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sudoku/board.dart';
import 'package:sudoku/widget_board.dart';
import 'package:tuple/tuple.dart';

class BoardScreen extends StatefulWidget {
  static const int _margin = 8;
  late final Board board;
  double cellSize = 0;
  bool showInput = false;
  int selectedRow = 0, selectedColumn = 0;

  BoardScreen(String data, {Difficulty dif = Difficulty.medium, super.key}) {
    log('BoardScreen(): data: $data dif:$dif');
    if (data.length != Board.boardSize * Board.boardSize) {
      log('BoardScreen: wrong data');
      return;
    }
    board = Board(data: data, dif: dif);
  }

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    log('BoardScreen:build()');
    int boardLength = math.min(MediaQuery.of(context).size.shortestSide.toInt(),
            MediaQuery.of(context).size.longestSide ~/ 2) -
        BoardScreen._margin * 2;
    widget.cellSize = (boardLength / (Board.boardSize + 2)).floorToDouble();
    var inputPositionX =
        MediaQuery.of(context).size.width / 2 - (widget.cellSize * 1.5);
    inputPositionX -= (4 - widget.selectedColumn) * widget.cellSize;
    var inputPositionY =
        MediaQuery.of(context).size.height / 2 - (widget.cellSize * 1.5);
    inputPositionY -= (4 - widget.selectedRow) * widget.cellSize;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BoardWidget(widget.board, widget.cellSize, (int row, int col) {
              setState(() {
                widget.selectedRow = row;
                widget.selectedColumn = col;
                widget.showInput = true;
                log('selectedRow:${widget.selectedRow}, ' +
                    'selectedColumn:${widget.selectedColumn} ' +
                    'showInput:${widget.showInput}');
              });
            }),
            //blocker
            Visibility(
              visible: widget.showInput,
              child: Container(
                color: Colors.grey.withOpacity(0.7),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.showInput = false;
                    });
                  },
                ),
              ),
            ),
            //input
            Positioned(
              left: inputPositionX,
              top: inputPositionY,
              child: Visibility(
                visible: widget.showInput,
                child: createInput(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            createInputCell(1),
            createInputCell(4),
            createInputCell(7),
          ],
        ),
        Column(
          children: [
            createInputCell(2),
            createInputCell(5),
            createInputCell(8),
            createInputCell(0),
          ],
        ),
        Column(
          children: [
            createInputCell(3),
            createInputCell(6),
            createInputCell(9),
          ],
        ),
      ],
    );
  }

  Widget createInputCell(int value) {
    Widget cell;
    if (value <= 0) {
      cell = const Icon(Icons.close);
    } else {
      cell = Text('$value');
    }
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: widget.cellSize,
        height: widget.cellSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                log('Set value: $value');
                widget.board.setValue(
                    value: value,
                    row: widget.selectedRow,
                    col: widget.selectedColumn);
                widget.showInput = false;
                widget.selectedRow = 0;
                widget.selectedColumn = 0;
              });
            },
            child: FittedBox(
              child: cell,
            ),
          ),
        ),
      ),
    );
  }
}
