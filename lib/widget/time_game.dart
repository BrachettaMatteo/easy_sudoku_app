import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_app/bloc/game_bloc.dart';

class TimeGame extends StatefulWidget {
  const TimeGame({super.key});

  @override
  State<TimeGame> createState() => _TimeGameState();
}

class _TimeGameState extends State<TimeGame> {
  Stopwatch sw = Stopwatch();
  bool win = false;

  @override
  void initState() {
    setState(() {
      sw.start();
      _viewTime();
    });
    super.initState();
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        final state = BlocProvider.of<GameBloc>(context).state;
        if (state is GameStateInitial) {
          setState(() {
            sw.reset();
            sw.start();
            _viewTime();
          });
        }

        if (state is GameStateFinished) {
          setState(() {
            sw.stop();
            win = state.win;
          });
        }
      },
      child: sw.isRunning
          ? RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.timer,
                      size: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  TextSpan(
                      text: " ( ${formatTime(sw.elapsed.inSeconds)})",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            )
          : _textClose(),
    );
  }

  Future<void> _viewTime() async {
    while (sw.isRunning) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  _textClose() => Text(
        "( ${formatTime(sw.elapsed.inSeconds)})",
        style: TextStyle(color: win ? Colors.green : Colors.red),
      );
}
