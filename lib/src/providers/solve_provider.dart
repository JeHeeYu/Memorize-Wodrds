import 'package:flutter/material.dart';

class SolveProvider extends ChangeNotifier {
  final int _solveListMaxCount = 5;
  int _currentSolveCount = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;

  int getSolveListMaxCount() => _solveListMaxCount;

  int getCurrentSolveCount() => _currentSolveCount;

  void setCurrentSolveCount() {
    _currentSolveCount++;
    notifyListeners();
  }

  int getCorrectCount() => _correctCount;

  void setCorrectCount() {
    _correctCount++;
    notifyListeners();
  }

  int getIncorrectCount() => _incorrectCount;
  
  void setIncorrectCount() {
    _incorrectCount++;
    notifyListeners();
  }
}
