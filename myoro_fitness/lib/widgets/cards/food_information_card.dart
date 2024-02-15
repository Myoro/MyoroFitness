import 'package:flutter/material.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/widgets/cards/base_card.dart';
import 'package:myoro_fitness/widgets/inputs/calorie_input.dart';
import 'package:myoro_fitness/widgets/outputs/nutrient_list_output.dart';

/// Calories and nutrients of the selected [FoodModel] to be added
class FoodInformationCard extends StatefulWidget {
  final FoodModel food;

  const FoodInformationCard({super.key, required this.food});

  @override
  State<FoodInformationCard> createState() => _FoodInformationCardState();
}

class _FoodInformationCardState extends State<FoodInformationCard> {
  final TextEditingController _calorieController = TextEditingController();
  final TextEditingController _servingController = TextEditingController();

  @override
  void dispose() {
    _calorieController.dispose();
    _servingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BaseCard(
      titleCentered: true,
      content: Column(
        children: [
          if (widget.food.calories != null)
            CalorieInput(
              calories: widget.food.calories!,
              calorieController: _calorieController,
              servingController: _servingController,
            ),
          const SizedBox(height: 10),
          NutrientListOutput(availableNutrients: widget.food.availableNutrients),
          if (widget.food.ingredients != null) ...[
            const SizedBox(height: 20),
            Text(
              'Ingredients',
              style: textTheme.titleMedium,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Text(
                widget.food.ingredients!,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall,
              ),
            ),
          ],
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
