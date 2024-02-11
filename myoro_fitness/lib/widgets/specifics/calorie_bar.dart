import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
import 'package:myoro_fitness/widgets/outputs/basic_output.dart';

/// Shows a bar of how many calories the user has consumed today
///
/// Also has buttons on the ends of the widget to scroll between days
class CalorieBar extends StatelessWidget {
  const CalorieBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        ButtonWithoutFeedback(
          onTap: () {}, // TODO
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: screenWidth - 116,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 5,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  alignment: screenWidth >= 500 ? WrapAlignment.spaceBetween : WrapAlignment.center,
                  children: [
                    if (screenWidth >= 500)
                      const BasicOutput(
                        title: 'Calorie Plan',
                        value: '12345',
                        size: SizeEnum.small,
                      ),
                    const BasicOutput(
                      title: 'Calories Consumed',
                      value: '123456',
                      size: SizeEnum.small,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        ButtonWithoutFeedback(
          onTap: () {}, // TODO
          child: Icon(
            Icons.arrow_forward,
            size: 30,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
