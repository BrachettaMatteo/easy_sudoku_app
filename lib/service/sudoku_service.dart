import 'package:collection/collection.dart';
import 'package:sudoku_app/model/global_data.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

import '../model/position.dart';

class SudokuService {
  late SudokuGenerator _generator;
  late List<List<int?>> _game;
  late List<List<int?>> _solution;

  SudokuService() {
    _generator = SudokuGenerator();
    _solution = List.empty();
    _game = List.empty();
  }

  List<List<int?>> newGame() {
    List<List<int?>> out = _generator.newSudoku;
    _game = out;
    _solution = _generator.newSudokuSolved;
    GlobalData.reset();
    _nextPosition();
    return out;
  }

  bool insertNumber(int number) {
    List<int?> row = _game.elementAt(GlobalData.currentPosition!.x);
    if (row.elementAt(GlobalData.currentPosition!.y) == 0) {
      row[GlobalData.currentPosition!.y] = number;
      _game[GlobalData.currentPosition!.x] = row;
      _nextPosition();
      return true;
    } else {
      return false;
    }
  }

  List<List<int?>> get getGame => _game;

  bool closeGame() {
    GlobalData.currentPosition = null;
    return const DeepCollectionEquality().equals(_solution, _game);
  }

  bool checkGame() {
    int checkRow = 0;
    for (var element in _game) {
      if (element.contains(0)) checkRow++;
    }
    return checkRow == 0;
  }

  void _nextPosition() {
    if (GlobalData.currentPosition != null) {
      for (List<int?> element
          in _game.getRange(GlobalData.currentPosition!.x, _game.length)) {
        if (element.contains(0)) {
          int indexX = _game.indexOf(element);
          int indexY = element.indexOf(0);
          GlobalData.currentPosition!.setPosition(x: indexX, y: indexY);
          return;
        }
      }
      GlobalData.currentPosition != Position(x: 0, y: 0)
          ? GlobalData.reset()
          : GlobalData.currentPosition = null;
      _nextPosition();
    }
  }
}
