import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/widgets/bodies/home_screen_body.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
import 'package:myoro_fitness/widgets/cards/base_card.dart';
import 'package:myoro_fitness/widgets/outputs/basic_output.dart';
import 'package:myoro_fitness/widgets/screens/food_selection_screen.dart';

/// Card used to show the foods & calories of a meal
///
/// Used in [HomeScreenBody]
class MealCard extends StatelessWidget {
  /// Breakfast, Lunch, Dinner, or Snacks
  final String mealName;

  const MealCard({super.key, required this.mealName});

  @override
  Widget build(BuildContext context) => BaseCard(
        title: mealName,
        extraAction: ButtonWithoutFeedback(
          tooltip: 'Add Food',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FoodSelectionScreen(),
            ),
          ),
          child: Icon(
            Icons.add,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        content: Column(
          children: [
            const _Foods(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (MediaQuery.of(context).size.width > 400) ...[
                  const BasicOutput(
                    size: SizeEnum.small,
                    title: 'Suggested',
                    value: '12345 cals',
                  ),
                  const Spacer(),
                ],
                const BasicOutput(
                  size: SizeEnum.small,
                  title: 'Actual',
                  value: '12345 cals',
                ),
              ],
            ),
          ],
        ),
      );
}

class _Foods extends StatelessWidget {
  const _Foods();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // TODO: Could be a better way to do this
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const _Divider(),
          const SizedBox(height: 10),
          // TODO: Remove
          for (int i = 0; i < 5; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth > 570 ? 400 : 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Food namqwjeioqwjqjoijopjiuhiuyhiouhiuohiuhiughoiweje',
                          style: textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Company',
                          style: textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text('12345 cals', style: textTheme.bodyMedium),
                ],
              ),
            ),
          const SizedBox(height: 10),
          const _Divider(),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: 0.5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
}
