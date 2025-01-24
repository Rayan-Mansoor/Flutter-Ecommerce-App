import 'package:flutter/material.dart';
import 'presentation/screens/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Zephyr',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MainScreen(),
    );
  }
}