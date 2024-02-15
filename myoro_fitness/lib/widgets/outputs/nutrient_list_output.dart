import 'package:flutter/material.dart';
import 'package:myoro_fitness/models/nutrient_model.dart';
import 'package:myoro_fitness/widgets/cards/food_information_card.dart';

/// Output used to show all of the nutrients of a selected food
///
/// Used in [FoodInformationCard]
class NutrientListOutput extends StatelessWidget {
  final List<NutrientModel> availableNutrients;

  const NutrientListOutput({super.key, required this.availableNutrients});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'Nutrients',
          style: textTheme.titleMedium,
        ),
        for (final NutrientModel nutrient in availableNutrients)
          Wrap(
            spacing: 10,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  '${nutrient.name}:',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  '${nutrient.value}${nutrient.unit != null ? ' ${nutrient.unit!.notation}' : ''}',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
