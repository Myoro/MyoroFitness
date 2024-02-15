import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_fitness/widgets/cards/base_card.dart';
import 'package:myoro_fitness/widgets/inputs/base_text_field.dart';

/// Calories and nutrients of the selected [FoodModel] to be added
class FoodInformationCard extends StatelessWidget {
  final FoodModel food;

  const FoodInformationCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) => BaseCard(
        title: 'Information about ${food.name}',
        content: const Column(
          children: [
            _CalorieInput(),
          ],
        ),
      );
}

class _CalorieInput extends StatefulWidget {
  const _CalorieInput();

  @override
  State<_CalorieInput> createState() => _CalorieInputState();
}

class _CalorieInputState extends State<_CalorieInput> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          IconButtonWithoutFeedback(
            onTap: () {},
            icon: Icons.arrow_drop_up,
          ),
          const BaseTextField(
            size: SizeEnum.medium,
            width: 80,
            bordered: false,
          ),
          IconButtonWithoutFeedback(
            onTap: () {},
            icon: Icons.arrow_drop_down,
          ),
        ],
      );
}
