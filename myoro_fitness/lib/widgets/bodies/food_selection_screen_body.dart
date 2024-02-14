import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/bodies/base_body.dart';
import 'package:myoro_fitness/widgets/screens/food_selection_screen.dart';

/// [Scaffold] body of [FoodSelectionScreen]
class FoodSelectionScreenBody extends StatelessWidget {
  const FoodSelectionScreenBody({super.key});

  @override
  Widget build(BuildContext context) => const BaseBody(
        children: [
          _Food(),
        ],
      );
}

class _Food extends StatelessWidget {
  const _Food();

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Text('Start'),
        ],
      );
}
