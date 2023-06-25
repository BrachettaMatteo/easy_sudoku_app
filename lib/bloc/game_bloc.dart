import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_app/service/sudoku_service.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late SudokuService _sudokuService;

  GameBloc() : super(GameStateInitial()) {
    on<GameEventInitial>((event, emit) {
      _sudokuService = SudokuService();
      _sudokuService.newGame();
      emit(GameStatePlay(game: _sudokuService.getGame));
    });
    on<GameEventAddNumbers>((event, emit) {
      _sudokuService.insertNumber(event.number);
      if (_sudokuService.checkGame()) {
        emit(GameStateFinished(
            game: _sudokuService.getGame, win: _sudokuService.closeGame()));
      } else {
        emit(GameStatePlay(game: _sudokuService.getGame));
      }
    });
    on<GameEventNewGame>((event, emit) => emit(GameStateInitial()));
    on<GameEventComplete>((event, emit) => null);
  }
}
