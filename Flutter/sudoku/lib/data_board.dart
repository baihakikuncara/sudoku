import 'dart:math';

import 'package:flutter/services.dart';

class BoardsData {
  static const _assetName = 'assets/boards';

  static final BoardsData _instance = BoardsData._internal();
  List<String> boardList = [];
  Random rng = Random();

  factory BoardsData() {
    return _instance;
  }

  BoardsData._internal() {
    loadAsset();
  }

  Future<void> loadAsset() async {
    String text = await rootBundle.loadString(_assetName);
    boardList.addAll(text.split('\n'));
  }

  String getRandomBoard() {
    return boardList[rng.nextInt(boardList.length)];
  }
}
