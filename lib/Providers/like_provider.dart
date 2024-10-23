import 'package:flutter/material.dart';

class LikeProvider extends ChangeNotifier {
  List<bool> ll = [];
  void genreateLike(int n) {
    ll = List.generate(n, (_) => false);
  }

  void makeDislike(int index) {
    ll[index] = false;
    notifyListeners();
  }

  void makeLiked(int index) {
    ll[index] = true;
    notifyListeners();
  }

  bool isLiked(int index) {
    return ll[index];
  }
}
