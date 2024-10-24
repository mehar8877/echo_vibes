import 'dart:math';
import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  List<Color> _currentGradient = [Colors.black, Colors.black];
  List<Color>? _previousGradient;

  final List<List<Color>> _colorPalette = [
    [Colors.purpleAccent, Colors.deepPurple],
    [Colors.orangeAccent, Colors.deepOrange],
    [Colors.greenAccent, Colors.teal],
    [Colors.yellowAccent, Colors.amber],
    [Colors.blueAccent, Colors.indigo],
    [Colors.pinkAccent, Colors.redAccent],
    [Colors.lightBlueAccent, Colors.cyan],
  ];

  List<Color> get currentGradient => _currentGradient;

  void generateRandomGradient() {
    final Random random = Random();
    List<Color> newGradient;

    do {
      newGradient = _colorPalette[random.nextInt(_colorPalette.length)];
    } while (_previousGradient != null && newGradient == _previousGradient);

    _previousGradient = newGradient;
    _currentGradient = newGradient;

    notifyListeners();
  }
}
