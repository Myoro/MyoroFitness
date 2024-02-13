import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/calorie_plan_cubit.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/models/calorie_plan_model.dart';
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
    // TODO: Could be a better way to do this
    final double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<CaloriePlanCubit, CaloriePlanModel>(
      builder: (context, caloriePlan) => Row(
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
                          title: 'Calories Consumed',
                          value: '12345',
                          size: SizeEnum.small,
                        ),
                      BasicOutput(
                        title: 'Calorie Plan',
                        value: caloriePlan.caloriesPerDay.toString(),
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
      ),
    );
  }
}
