import 'package:flutter/material.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/widgets/bodies/base_body.dart';
import 'package:myoro_fitness/widgets/screens/food_selection_screen.dart';

/// [Scaffold] body of [FoodSelectionScreen]
class FoodSelectionScreenBody extends StatelessWidget {
  const FoodSelectionScreenBody({super.key});

  @override
  Widget build(BuildContext context) => const BaseBody(
        children: [
          // TODO: Finish FoodModelConstants, NutrientModelConstants, and replacing FoodModel fromJSON with NutrientsEnum
          // _Food(),
        ],
      );
}

class _Food extends StatelessWidget {
  final FoodModel food;

  const _Food(this.food);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Column(
          children: [
            Text(food.name, style: textTheme.bodyMedium),
            if(food.brand != null) Text(food.brand!, style: textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
