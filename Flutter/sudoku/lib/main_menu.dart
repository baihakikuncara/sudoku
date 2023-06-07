import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/boards_data.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  static const double _buttonWidth = 200;
  static const double _buttonMargin = 8;
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
    return SizedBox(
        width: _buttonWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            createButton(
              title: "New Game",
              action: () {
                log('button pressed: new game');
                setState(() {
                  showDifficulty = true;
                });
              },
            ),
            createButton(
              title: "Continue",
              action: () {
                log('button pressed: continue');
              },
            ),
            createButton(
              title: "Exit",
              action: () {
                log('button pressed: exit');
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else {
                  exit(0);
                }
              },
            ),
          ],
        ));
  }

  Widget difficultyButtons(BuildContext context) {
    return SizedBox(
        width: _buttonWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            createButton(
                title: "Easy",
                action: () {
                  log('button pressed: easy');
                }),
            createButton(
                title: "Medium",
                action: () {
                  log('button pressed: medium');
                }),
            createButton(
                title: "Hard",
                action: () {
                  log('button pressed: hard');
                  log(BoardsData().boardList[1]);
                }),
            createButton(
                title: "Cancel",
                action: () {
                  log('button pressed: back');
                  setState(() {
                    showDifficulty = false;
                  });
                }),
          ],
        ));
  }

  Widget createButton({String title = 'Button', Function()? action}) {
    return Container(
      margin: const EdgeInsets.all(_buttonMargin),
      child: ElevatedButton(
        onPressed: action,
        child: Text(title),
      ),
    );
  }
}
