import 'dart:async';

import 'package:flutter/material.dart';

class LikeProvider extends ChangeNotifier {
  List<bool> ll = [];
  bool _isDoubleTapped = false;
  bool get isDobuleTapped => _isDoubleTapped;

  void genreateLike(int n) {
    ll = List.generate(n, (_) => false);
  }

  void toggle(int index) {
    ll[index] = !ll[index];
    notifyListeners();
  }

  void makeLiked(int index) {
    _isDoubleTapped = true;
    ll[index] = true;
    notifyListeners();
    Timer(Duration(seconds: 1), () {
      _isDoubleTapped = false;
      notifyListeners();
    });
  }

  bool isLiked(int index) {
    return ll[index];
  }
}
