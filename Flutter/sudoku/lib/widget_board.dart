import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/board.dart';

class BoardWidget extends StatelessWidget {
  static const TextStyle normalCell = TextStyle(color: Colors.black);
  static const TextStyle duplicateCell = TextStyle(color: Colors.red);
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

  const BoardWidget(this.data, this.cellSize, {super.key});

  @override
  Widget build(BuildContext context) {
    log('BoardWidget:build()');
    List<Widget> rows = [];
    for (var r = 0; r < Board.boardSize; r++) {
      List<Widget> row = [];
      for (var c = 0; c < Board.boardSize; c++) {
        //row.add(createBlock(rowBlock, colBlock));
        row.add(createCell(val: data.getValue(row: r, col: c), row: r, col: c));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: row,
      ));
    }
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
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rows,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: blockRows,
        ),
      ],
    );
  }

  Widget createCell({required val, required row, required col}) {
    log('BoardWidget:createCell(val:$val, row:$row, col:$col)');
    return SizedBox(
      width: cellSize,
      height: cellSize,
      child: GestureDetector(
        onTap: () {
          log('cell tapped: value:$val, row:$row, col:$col');
        },
        child: DecoratedBox(
          decoration:
              data.isEditable(row, col) ? cellDecoration : fixedCellDecoration,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              val == 0 ? ' ' : '$val',
              style: data.haveDuplicate(row, col) ? duplicateCell : normalCell,
            ),
          ),
        ),
      ),
    );
  }
}
