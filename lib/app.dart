import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_app/bloc/game_bloc.dart';
import 'package:sudoku_app/screen/home_page.dart';
import 'package:sudoku_app/screen/welcome_page.dart';
import 'package:sudoku_app/theme/theme_custom.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GameBloc(),
          ),
        ],
        child: MaterialApp(
            title: 'Sudoku app',
            theme: ThemeCustom.lightTheme,
            darkTheme: ThemeCustom.darkTheme,
            initialRoute: initialRoute,
            routes: {
              HomePage.route: (context) => const HomePage(),
              WelcomePage.route: (context) => const WelcomePage(),
            }));
  }
}
