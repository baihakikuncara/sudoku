import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

mixin MenuButtons {
  static const double _margin = 8;
  static const double _width = 200;

  Widget createButtons(List data) {
    List<Widget> buttons = [];
    for (Tuple2<String, Function()?> entry in data) {
      buttons.add(Container(
        margin: const EdgeInsets.all(_margin),
        child: ElevatedButton(
          onPressed: entry.item2,
          child: Text(entry.item1),
        ),
      ));
    }
    return SizedBox(
      width: _width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons,
      ),
    );
  }
}
