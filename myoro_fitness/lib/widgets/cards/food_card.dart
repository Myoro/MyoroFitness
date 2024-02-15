import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/unit_enum.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
import 'package:myoro_fitness/widgets/cards/base_card.dart';
import 'package:myoro_fitness/widgets/screens/food_information_screen.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ButtonWithoutFeedback(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodInformationScreen(food: food),
        ),
      ),
      child: BaseCard(
        padding: const EdgeInsets.symmetric(vertical: 5),
        content: Row(
          children: [
            SizedBox(
              width: screenWidth - 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium,
                  ),
                  if (food.brand != null)
                    Text(
                      food.brand!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            const Spacer(),
            if (food.calories != null)
              Text(
                '${food.calories!.value.toInt()} ${UnitEnum.calories.notation.toLowerCase()}',
                style: textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
