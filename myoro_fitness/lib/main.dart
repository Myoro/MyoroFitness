import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:window_manager/window_manager.dart";
import "package:myoro_fitness/bloc/dark_mode_bloc.dart";
import "package:myoro_fitness/bloc/tdee_bloc.dart";
import "package:myoro_fitness/themes.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/widgets/top_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/footer_navigation_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/side_navigation_bar.dart";
import "package:myoro_fitness/pages/calories_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(!Platform.isAndroid && !Platform.isIOS) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(500, 600));
  }

  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]);

  if(kDebugMode) await Database().resetDatabase();
  await Database().init;

  runApp(
    BlocProvider(
      create: (context) => DarkModeBloc(),
      child:  const App(),
    )
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarkModeBloc, DarkModeState>(
      builder: (context, darkModeState) {
        return BlocProvider(
          create: (context) => TDEEBloc(),
          child: MaterialApp(
            title: "MyoroFitness",
            theme: darkModeState.enabled ? dark : light,
            home:  Scaffold(
              appBar: const TopBar(),
              body: (Platform.isAndroid || Platform.isIOS)
                ? const Column(
                  children: [
                    CaloriesPage(),
                    FooterNavigationBar()
                  ]
                )
                :
                const Row(
                  children: [
                    SideNavigationBar(),
                    CaloriesPage()
                  ]
                )
            )
          ),
        );
      }
    );
  }
}