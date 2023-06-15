import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/board.dart';

class BoardWidget extends StatelessWidget {
  final Board data;
  final double cellSize;

  const BoardWidget(this.data, this.cellSize, {super.key});

  @override
  Widget build(BuildContext context) {
    log('BoardWidget:build()');
    List<Widget> rows = [];
    for (var rowBlock = 0; rowBlock < Board.blockSize; rowBlock++) {
      List<Widget> row = [];
      for (var colBlock = 0; colBlock < Board.blockSize; colBlock++) {
        row.add(createBlock(rowBlock, colBlock));
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

  Widget createBlock(var rowBlock, var colBlock) {
    log('BoardWidget:createBlock(rowBlock:$rowBlock, colBlock:$colBlock)');
    List<Widget> rows = [];
    for (var r = rowBlock * Board.blockSize;
        r < Board.blockSize * (rowBlock + 1);
        r++) {
      List<Widget> col = [];
      for (var c = colBlock * Board.blockSize;
          c < Board.blockSize * (colBlock + 1);
          c++) {
        col.add(createCell(val: data.getValue(row: r, col: c), row: r, col: c));
      }
      rows.add(
        Row(
          children: col,
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepPurple,
          width: 2,
        ),
      ),
      child: Column(
        children: rows,
      ),
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(val == 0 ? ' ' : '$val'),
          ),
        ),
      ),
    );
  }
}
