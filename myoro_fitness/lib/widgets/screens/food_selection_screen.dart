import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/app_bars/food_selection_screen_app_bar.dart';
import 'package:myoro_fitness/widgets/bodies/food_selection_screen_body.dart';

/// Where the user will search for foods via API or add a custom food
class FoodSelectionScreen extends StatelessWidget {
  const FoodSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: FoodSelectionScreenAppBar(),
        body: FoodSelectionScreenBody(),
      );
}
