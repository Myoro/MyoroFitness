import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/unit_enum.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/widgets/cards/base_card.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BaseCard(
      padding: const EdgeInsets.symmetric(vertical: 5),
      content: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(food.name, style: textTheme.bodyMedium),
              if (food.brand != null) Text(food.brand!, style: textTheme.bodySmall),
            ],
          ),
          const Spacer(),
          if (food.calories != null)
            Text(
              '${food.calories!.value} ${UnitEnum.calories.notation.toLowerCase()}',
              style: textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}
