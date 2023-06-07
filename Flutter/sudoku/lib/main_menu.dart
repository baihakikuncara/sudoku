import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sudoku/boards_data.dart';
import 'package:sudoku/menu_buttons.dart';
import 'package:tuple/tuple.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with MenuButtons {
  late Widget currentButtons;
  final math.Random generator = math.Random();

  bool showDifficulty = false;
  @override
  Widget build(BuildContext context) {
    currentButtons =
        showDifficulty ? difficultyButtons(context) : mainMenuButtons(context);

    log('MainMenu:build()');
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
    return createButtons([
      Tuple2('Easy', () {}),
      Tuple2('Medium', () {}),
      Tuple2('Hard', () {}),
      Tuple2('Cancel', () {
        setState(() {
          showDifficulty = false;
        });
      }),
    ]);
  }
}
