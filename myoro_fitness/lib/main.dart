import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/calorie_plan_cubit.dart';
import 'package:myoro_fitness/blocs/dark_mode_cubit.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_bloc.dart';
import 'package:myoro_fitness/database.dart';
import 'package:myoro_fitness/models/calorie_plan_model.dart';
import 'package:myoro_fitness/theme.dart';
import 'package:myoro_fitness/widgets/screens/home_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Platform.isIOS && !Platform.isAndroid) {
    windowManager.ensureInitialized();
    windowManager.setMinimumSize(const Size(350, 350));
  }

  await Database.init();
  final bool isDarkMode = (await Database.get('dark_mode'))['enabled'] == 1 ? true : false;
  final CaloriePlanModel caloriePlan = CaloriePlanModel.fromJSON(await Database.get('calorie_plan'));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DarkModeCubit(isDarkMode)),
        BlocProvider(create: (context) => CaloriePlanCubit(caloriePlan)),
        BlocProvider(create: (context) => FoodSelectionBloc()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<DarkModeCubit, bool>(
        builder: (context, isDarkMode) => MaterialApp(
          title: 'Myoro Fitness',
          theme: createTheme(isDarkMode),
          home: const HomeScreen(),
        ),
      );
}
