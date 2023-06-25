import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_app/bloc/game_bloc.dart';

class SnackService {
  showMessageSnack(String message, BuildContext context, bool success) {
    SnackBar snack = success
        ? _getSuccessSnackBar(message: message, context: context)
        : _getLoseSnackBar(message: message, context: context);
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  _getLoseSnackBar({required String message, required BuildContext context}) =>
      SnackBar(
        duration: const Duration(seconds: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.red.shade500,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'new game',
          onPressed: () {
            BlocProvider.of<GameBloc>(context).add(GameEventNewGame());
          },
        ),
      );

  _getSuccessSnackBar(
          {required String message, required BuildContext context}) =>
      SnackBar(
          backgroundColor: Colors.green.shade500,
          duration: const Duration(seconds: 10),
          content: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          action: SnackBarAction(
            label: 'new game',
            onPressed: () {
              BlocProvider.of<GameBloc>(context).add(GameEventNewGame());
            },
          ));
}
