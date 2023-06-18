import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/board.dart';

class BoardWidget extends StatelessWidget {
  static final BoxDecoration blockDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.deepPurple,
      width: 2,
    ),
  );
  static final BoxDecoration cellDecoration = BoxDecoration(
    border: Border.all(color: Colors.blueAccent),
  );
  static final BoxDecoration fixedCellDecoration = BoxDecoration(
    border: Border.all(color: Colors.blueAccent),
    color: Colors.blue.shade50,
  );

  final Board data;
  final double cellSize;
  final Function setInput;

  const BoardWidget(this.data, this.cellSize, this.setInput, {super.key});

  @override
  Widget build(BuildContext context) {
    log('BoardWidget:build()');

    return Stack(
      children: [
        createBoard(),
        createBlockBorder(),
      ],
    );
  }

  Widget createCell({required val, required row, required col}) {
    //log('BoardWidget:createCell(val:$val, row:$row, col:$col)');
    return SizedBox(
      width: cellSize,
      height: cellSize,
      child: GestureDetector(
        onTap: () {
          log('cell tapped: value:$val, row:$row, col:$col');
          if (data.isEditable(row, col)) {
            setInput(row, col);
          }
        },
        child: DecoratedBox(
          decoration:
              data.isEditable(row, col) ? cellDecoration : fixedCellDecoration,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              val == 0 ? ' ' : '$val',
              style: TextStyle(
                color: data.haveDuplicate(row, col) ? Colors.red : Colors.black,
                fontWeight: data.isEditable(row, col)
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createBoard() {
    List<Widget> rows = [];
    for (var r = 0; r < Board.boardSize; r++) {
      List<Widget> row = [];
      for (var c = 0; c < Board.boardSize; c++) {
        row.add(createCell(val: data.getValue(r, c), row: r, col: c));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: row,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: rows,
    );
  }

  Widget createBlockBorder() {
    List<Widget> blockRows = [];
    for (var r = 0; r < Board.blockSize; r++) {
      List<Widget> row = [];
      for (var c = 0; c < Board.blockSize; c++) {
        row.add(DecoratedBox(
          decoration: blockDecoration,
          child: SizedBox(
            height: cellSize * Board.blockSize,
            width: cellSize * Board.blockSize,
          ),
        ));
      }
      blockRows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: row,
      ));
    }
    return IgnorePointer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: blockRows,
      ),
    );
  }
}
