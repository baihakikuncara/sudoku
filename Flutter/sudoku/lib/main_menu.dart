import 'dart:developer';
import 'dart:io';

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

  bool showDifficulty = false;
  @override
  Widget build(BuildContext context) {
    currentButtons =
        showDifficulty ? difficultyButtons() : mainMenuButtons(context);

    log('MainMenu:build()');
    return MaterialApp(
      home: Scaffold(
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
      ),
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

  Widget difficultyButtons() {
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
                  log(BoardsData().boardList[0]);
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
