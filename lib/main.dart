import 'package:flutter/material.dart';
import 'package:sudoku_app/model/global_data.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyApp myApp = MyApp(initialRoute: await GlobalData.initilRoute);
  runApp(myApp);
}
