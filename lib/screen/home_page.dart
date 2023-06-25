import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_app/bloc/game_bloc.dart';
import 'package:sudoku_app/service/snack_service.dart';

import '../widget/board.dart';
import '../widget/input_keyboard.dart';
import '../widget/time_game.dart';

class HomePage extends StatefulWidget {
  static String route = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<GameBloc>(context).add(GameEventInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sudoku"),
        titleTextStyle: TextStyle(
            fontSize: 20,
            letterSpacing: 5,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(context).add(GameEventNewGame());
              },
              icon: Icon(
                Icons.refresh_outlined,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Board(),
          const TimeGame(),
          BlocListener<GameBloc, GameState>(
              listener: (context, state) {
                final state = BlocProvider.of<GameBloc>(context).state;
                if (state is GameStateFinished) {
                  setState(() {});
                  SnackService().showMessageSnack(
                      state.win
                          ? "Win, good game"
                          : "You lost, better luck next time",
                      context,
                      state.win);
                }
              },
              child: const InputKeyboard()),
        ],
      )),
    );
  }
}
