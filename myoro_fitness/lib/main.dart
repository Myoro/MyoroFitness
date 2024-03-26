import 'package:flutter/material.dart';
import 'package:myoro_fitness/desktop/main_screen/main_screen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'MyoroFitness',
        home: MainScreen(),
      );
}
