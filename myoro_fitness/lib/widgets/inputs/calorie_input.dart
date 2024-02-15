import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/formatters/calorie_input_formatter.dart';
import 'package:myoro_fitness/models/nutrient_model.dart';
import 'package:myoro_fitness/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_fitness/widgets/inputs/base_text_field.dart';
import 'package:myoro_fitness/widgets/cards/food_information_card.dart';

/// Input where the user may directly input a calorie amount, or use the two arrows to in/decrement
///
/// Used in [FoodInformationCard]
class CalorieInput extends StatefulWidget {
  /// Calories of said food being added
  final NutrientModel calories;

  /// [TextEditingController] of [BaseTextField]
  final TextEditingController controller;

  const CalorieInput({
    super.key,
    required this.calories,
    required this.controller,
  });

  @override
  State<CalorieInput> createState() => _CalorieInputState();
}

class _CalorieInputState extends State<CalorieInput> {
  late final ValueNotifier<double> _calorieTextFieldWidth = ValueNotifier<double>(60);

  void _setCalorieTextFieldWidth(int inputTextLength) {
    switch (inputTextLength) {
      case 0:
        _calorieTextFieldWidth.value = 10;
        break;
      case 1:
        _calorieTextFieldWidth.value = 20;
        break;
      case 2:
        _calorieTextFieldWidth.value = 30;
        break;
      case 3:
        _calorieTextFieldWidth.value = 40;
        break;
      case 4:
        _calorieTextFieldWidth.value = 50;
        break;
      case 5:
        _calorieTextFieldWidth.value = 60;
        break;
    }
  }

  void _changeCalories({required bool decrement}) {
    if (decrement) {
      if (int.parse(widget.controller.text) - 25 > 0) {
        widget.controller.text = (int.parse(widget.controller.text) - 25).toString();
      }
    } else {
      if (widget.controller.text.length < 5) {
        widget.controller.text = (int.parse(widget.controller.text) + 25).toString();
      }
    }

    _setCalorieTextFieldWidth(widget.controller.text.length);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.calories.value.toString();
    _setCalorieTextFieldWidth(widget.calories.value.toString().length);
  }

  @override
  void dispose() {
    _calorieTextFieldWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            'Calories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButtonWithoutFeedback(
            onTap: () => _changeCalories(decrement: false),
            icon: Icons.arrow_drop_up,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: _calorieTextFieldWidth,
                builder: (context, width, child) => BaseTextField(
                  size: SizeEnum.small,
                  width: width,
                  bordered: false,
                  controller: widget.controller,
                  padding: const EdgeInsets.only(bottom: 18),
                  formatters: [CalorieInputFormatter()],
                  onChanged: (value) => _setCalorieTextFieldWidth(value.length),
                ),
              ),
              Text(
                'cals',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          IconButtonWithoutFeedback(
            onTap: () => _changeCalories(decrement: true),
            icon: Icons.arrow_drop_down,
          ),
        ],
      );
}
