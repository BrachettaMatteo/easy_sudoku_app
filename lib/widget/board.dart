import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_app/bloc/game_bloc.dart';
import 'package:sudoku_app/model/global_data.dart';
import 'package:sudoku_app/model/position.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late List<List<int?>> _game;

  @override
  void initState() {
    _game = List.empty();
    final state = BlocProvider.of<GameBloc>(context).state;
    if (state is GameStatePlay) {
      setState(() {
        _game = state.game;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        final state = BlocProvider.of<GameBloc>(context).state;
        if (state is GameStateInitial) {
          BlocProvider.of<GameBloc>(context).add(GameEventInitial());
        }
        if (state is GameStatePlay) {
          setState(() {
            _game = state.game;
          });
        }
        if (state is GameStateFinished) {
          setState(() {
            _game = state.game;
          });
          BlocProvider.of<GameBloc>(context).add(GameEventComplete());
        }
      },
      child: SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width * 0.9,
          child: _boardGame()),
    );
  }

  _boardGame() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return _getSubGrid(index);
        },
        itemCount: _game.length,
      );

  GridView _getSubGrid(int index) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, subIndex) {
          return _elementBox(
              _game[index][subIndex], Position(x: index, y: subIndex));
        },
        itemCount: _game[index].length,
      );

  Widget _elementBox(int? valueElement, Position p) {
    return Container(
        margin: const EdgeInsets.all(2),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            boxShadow: [
              if (GlobalData.currentPosition == p)
                const BoxShadow(
                  color: Colors.red,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                )
            ],
            color: Colors.grey.shade400,
            border: Border.all(
                color: GlobalData.currentPosition == p
                    ? Colors.red
                    : Colors.transparent)),
        child: valueElement == 0
            ? TextButton(
                onPressed: () {
                  setState(() {
                    GlobalData.currentPosition = p;
                  });
                },
                child: const Text(""),
              )
            : Center(
                child: Text(
                valueElement.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )));
  }
}
