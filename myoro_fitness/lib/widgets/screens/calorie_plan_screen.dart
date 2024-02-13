import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/app_bars/calorie_plan_screen_app_bar.dart';
import 'package:myoro_fitness/widgets/bodies/calorie_plan_screen_body.dart';

/// Screen where the user can view & edit their calorie plan
class CaloriePlanScreen extends StatelessWidget {
  const CaloriePlanScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: CaloriePlanScreenAppBar(),
        body: CaloriePlanScreenBody(),
      );
}
