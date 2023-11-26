import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/dark_mode_bloc.dart";
import "package:myoro_fitness/themes.dart";
import "package:myoro_fitness/screens/main_screen.dart";

void main() => runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider<DarkModeBloc>(create: (context) => DarkModeBloc())
    ],
    child: const App()
  )
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarkModeBloc, DarkModeState>(
      builder: (context, darkModeState) {
        return MaterialApp(
          title: "MyoroFitness",
          theme: darkModeState.enabled ? dark : light,
          home:  const MainScreen()
        );
      }
    );
  }
}