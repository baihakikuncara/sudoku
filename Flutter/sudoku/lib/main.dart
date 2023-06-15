import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/data_board.dart';

import 'screen_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BoardsData();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    log('MainApp:build()');
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
