import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  List<Color> _currentGradient = [Colors.black, Colors.black];
  int index = 0;
  final List<List<Color>> _colorPalette = [
    [Colors.black, Colors.black],
    [Colors.purpleAccent, Colors.deepPurple],
    [Colors.orangeAccent, Colors.deepOrange],
    [Colors.greenAccent, Colors.teal],
    [Colors.blueAccent, Colors.indigo],
    [Colors.pinkAccent, Colors.redAccent],
    [Colors.lightBlueAccent, Colors.cyan],
  ];

  List<Color> get currentGradient => _currentGradient;

  void generateRandomGradient() {
    index++;
    if (index >= _colorPalette.length) index = 0;
    _currentGradient = _colorPalette[index];
    notifyListeners();
  }
}
