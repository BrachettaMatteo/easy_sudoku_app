part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameStateInitial extends GameState {}

class GameStatePlay extends GameState {
  final List<List<int?>> game;
  GameStatePlay({required this.game});
}

class GameStateFinished extends GameState {
  final List<List<int?>> game;
  final bool win;
  GameStateFinished({required this.game, required this.win});
}
