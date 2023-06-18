import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/board.dart';
import 'package:sudoku/data_board.dart';
import 'package:sudoku/widget_board.dart';

class BoardScreen extends StatefulWidget {
  static const int _margin = 8;
  final Difficulty dif;

  const BoardScreen(this.dif, {super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late Board board;
  bool showInput = false;
  int selectedRow = 0, selectedColumn = 0;
  double cellSize = 0;

  @override
  void initState() {
    super.initState();
    board = Board(data: BoardsData().getRandomBoard(), dif: widget.dif);
  }

  @override
  Widget build(BuildContext context) {
    log('BoardScreen:build()');
    int boardLength = MediaQuery.of(context).size.shortestSide.toInt() -
        BoardScreen._margin * 2;
    cellSize = (boardLength / (Board.boardSize + 3)).floorToDouble();
    var inputPositionX =
        MediaQuery.of(context).size.width / 2 - (cellSize * 1.5);
    inputPositionX -= (4 - selectedColumn) * cellSize;
    var inputPositionY =
        MediaQuery.of(context).size.height / 2 - (cellSize * 1.5);
    inputPositionY -= (4 - selectedRow) * cellSize;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BoardWidget(board, cellSize, (int row, int col) {
              setState(() {
                selectedRow = row;
                selectedColumn = col;
                showInput = true;
                log('selectedRow:$selectedRow, selectedColumn:$selectedColumn, showInput:$showInput');
              });
            }),
            //blocker
            Visibility(
              visible: showInput,
              child: Container(
                color: Colors.grey.withOpacity(0.7),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showInput = false;
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
                visible: showInput,
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
        width: cellSize,
        height: cellSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                log('Set value: $value');
                board.setValue(
                    value: value, row: selectedRow, col: selectedColumn);
                showInput = false;
                selectedRow = 0;
                selectedColumn = 0;
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
