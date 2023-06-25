import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_app/model/position.dart';
import 'package:sudoku_app/screen/home_page.dart';
import 'package:sudoku_app/screen/welcome_page.dart';

class GlobalData {
  static Position? currentPosition = Position(x: 0, y: 0);
  static void reset() {
    currentPosition = Position(x: 0, y: 0);
  }

  static Future<String> get initilRoute async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool("first_login") ?? true) {
      pref.setBool("first_login", false);
      return WelcomePage.route;
    } else {
      return HomePage.route;
    }
  }
}
