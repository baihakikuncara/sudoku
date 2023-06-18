import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/board.dart';
import 'package:sudoku/screen_board.dart';

class HomeScreen extends StatelessWidget {
  static const double _margin = 8;
  static const double _width = 200;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('MainMenu:build()');

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            const Spacer(
              flex: 1,
            ),
            difficultyButtons(context),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget difficultyButtons(BuildContext context) {
    log('MainMenu:difficultyButtons()');
    return SizedBox(
      width: _width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          createButton('Easy', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BoardScreen(Difficulty.easy)));
          }),
          createButton('Medium', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BoardScreen(Difficulty.easy)));
          }),
          createButton('Hard', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BoardScreen(Difficulty.easy)));
          }),
          createButton('Exit', () {
            if (Platform.isAndroid) SystemNavigator.pop();
          }),
        ],
      ),
    );
  }

  Widget createButton(String text, Function() fun) {
    return Container(
      margin: const EdgeInsets.all(_margin),
      child: ElevatedButton(
        onPressed: fun,
        child: Text(text),
      ),
    );
  }
}
