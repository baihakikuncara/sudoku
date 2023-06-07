import 'package:flutter/material.dart';
import 'package:sudoku/boards_data.dart';

import 'main_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BoardsData();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainMenu(),
    );
  }
}
