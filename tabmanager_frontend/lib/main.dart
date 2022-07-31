import 'package:flutter/material.dart';
import 'pages/home_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Manager',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomeView(),
    );
  }
}
