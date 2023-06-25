import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_app/bloc/game_bloc.dart';
import 'package:sudoku_app/model/global_data.dart';

class InputKeyboard extends StatelessWidget {
  const InputKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> keyboardKeys = List.generate(9, (index) => index + 1);
    keyboardKeys.remove(0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keyboardKeys.map((e) => _inputButton(e, context)).toList(),
      ),
    );
  }

  Widget _inputButton(int label, BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: IconButton(
        onPressed: () => {
          if (GlobalData.currentPosition != null)
            BlocProvider.of<GameBloc>(context)
                .add(GameEventAddNumbers(number: label))
        },
        icon: Text(
          label.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
