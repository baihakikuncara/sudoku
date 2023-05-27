import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        SizedBox(
          width: 200,
          child: mainMenuButtons(),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }

  Widget mainMenuButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        createButton(title: "New Game", action: () {}),
        const SizedBox(
          height: 16,
        ),
        createButton(title: "Continue", action: () {}),
        const SizedBox(
          height: 16,
        ),
        createButton(
            title: "Exit",
            action: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            }),
      ],
    );
  }

  Widget createButton({required String title, required Function()? action}) {
    return ElevatedButton(onPressed: action, child: Text(title));
  }
}
