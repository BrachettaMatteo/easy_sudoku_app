part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameEventInitial extends GameEvent {}

class GameEventAddNumbers extends GameEvent {
  final int number;

  GameEventAddNumbers({required this.number});
}

class GameEventError extends GameEvent {}

class GameEventComplete extends GameEvent {}

class GameEventNewGame extends GameEvent {}
