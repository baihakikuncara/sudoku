import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/board_screen.dart';
import 'package:sudoku/boards_data.dart';
import 'package:sudoku/menu_buttons.dart';
import 'package:sudoku/board.dart';
import 'package:tuple/tuple.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with MenuButtons {
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
