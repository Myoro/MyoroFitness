import 'package:flutter/material.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/widgets/bodies/base_body.dart';
import 'package:myoro_fitness/widgets/cards/food_information_card.dart';
import 'package:myoro_fitness/widgets/screens/food_information_screen.dart';

/// [Scaffold] body of [FoodInformationScreen]
class FoodInformationScreenBody extends StatelessWidget {
  final FoodModel food;

  const FoodInformationScreenBody({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BaseBody(
      children: [
        Column(
          children: [
            Text(food.name, style: textTheme.titleLarge, textAlign: TextAlign.center),
            if (food.brand != null) Text(food.brand!, style: textTheme.bodyMedium),
            const SizedBox(height: 10),
            FoodInformationCard(food: food),
          ],
        ),
      ],
    );
  }
}
