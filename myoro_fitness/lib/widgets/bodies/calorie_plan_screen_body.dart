import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/cards/calorie_plan_screen_information_card.dart';
import 'package:myoro_fitness/widgets/screens/calorie_plan_screen.dart';

/// [Scaffold] body of [CaloriePlanScreen]
class CaloriePlanScreenBody extends StatelessWidget {
  const CaloriePlanScreenBody({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 355,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: const [CaloriePlanScreenInformationCard()],
            ),
          ),
        ),
      );
}
