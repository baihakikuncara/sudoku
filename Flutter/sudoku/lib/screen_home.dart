import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/screen_board.dart';
import 'package:sudoku/data_board.dart';
import 'package:sudoku/button_menu.dart';
import 'package:sudoku/board.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with MenuButtons {
  late Widget currentButtons;

  bool showDifficulty = false;
  @override
  Widget build(BuildContext context) {
    log('MainMenu:build()');
    currentButtons =
        showDifficulty ? difficultyButtons(context) : mainMenuButtons(context);

    return Scaffold(
      body: Center(
          child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          currentButtons,
          const Spacer(
            flex: 1,
          ),
        ],
      )),
    );
  }

  Widget mainMenuButtons(BuildContext context) {
    log('MainMenu:mainMenuButtons()');
    return createButtons([
      Tuple2('New Game', () {
        setState(() {
          showDifficulty = true;
        });
      }),
      Tuple2('Continue', () {}),
      Tuple2('Exit', () {}),
    ]);
  }

  Widget difficultyButtons(BuildContext context) {
    log('MainMenu:difficultyButtons()');
    return createButtons([
      Tuple2('Easy', () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                BoardScreen(selectRandomBoard(), dif: Difficulty.easy)));
      }),
      Tuple2('Medium', () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                BoardScreen(selectRandomBoard(), dif: Difficulty.medium)));
      }),
      Tuple2('Hard', () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                BoardScreen(selectRandomBoard(), dif: Difficulty.hard)));
      }),
      Tuple2('Cancel', () {
        setState(() {
          showDifficulty = false;
        });
      }),
    ]);
  }

  String selectRandomBoard() {
    log('MainMenu:selectRandomBoard()');
    var index = BoardsData().rng.nextInt(BoardsData().boardList.length);
    return BoardsData().boardList[index];
  }
}
