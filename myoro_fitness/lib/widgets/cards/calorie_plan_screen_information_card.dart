import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/widgets/bodies/calorie_plan_screen_body.dart';
import 'package:myoro_fitness/widgets/buttons/icon_text_hover_button.dart';
import 'package:myoro_fitness/widgets/cards/base_card.dart';
import 'package:myoro_fitness/widgets/inputs/basic_text_field_form.dart';

/// Card used to display the user's current calorie plan
///
/// Used in [CaloriePlanScreenBody]
class CaloriePlanScreenInformationCard extends StatefulWidget {
  const CaloriePlanScreenInformationCard({super.key});

  @override
  State<CaloriePlanScreenInformationCard> createState() => _CaloriePlanScreenInformationCardState();
}

class _CaloriePlanScreenInformationCardState extends State<CaloriePlanScreenInformationCard> {
  final TextEditingController _caloriesPerDayController = TextEditingController();
  final TextEditingController _tdeeController = TextEditingController();

  @override
  void dispose() {
    _caloriesPerDayController.dispose();
    _tdeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BaseCard(
        title: 'Your Calorie Plan',
        titleCentered: true,
        content: Column(
          children: [
            const SizedBox(height: 10),
            BasicTextFieldForm(
              size: SizeEnum.medium,
              title: 'Calories Per Day',
              controller: _caloriesPerDayController,
              textFieldWidth: 100,
            ),
            const SizedBox(height: 5),
            BasicTextFieldForm(
              size: SizeEnum.medium,
              title: 'TDEE',
              tooltip: 'Total Daily Energy Expenditure',
              controller: _caloriesPerDayController,
              textFieldWidth: 100,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Difference',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: 100,
                  child: Text(
                    '12345',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            IconTextHoverButton(
              onTap: () => print('Inline'), // TODO
              text: 'Save Calorie Plan',
              bordered: true,
            ),
          ],
        ),
      );
}
