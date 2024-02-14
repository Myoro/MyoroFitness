import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/bodies/base_body.dart';
import 'package:myoro_fitness/widgets/cards/meal_card.dart';
import 'package:myoro_fitness/widgets/screens/home_screen.dart';
import 'package:myoro_fitness/widgets/specifics/calorie_bar.dart';

/// Body for [HomeScreen]
///
/// Where the user will track their calories
class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) => const BaseBody(
        children: [
          CalorieBar(),
          SizedBox(height: 10),
          MealCard(mealName: 'Breakfast'),
          SizedBox(height: 10),
          MealCard(mealName: 'Lunch'),
          SizedBox(height: 10),
          MealCard(mealName: 'Dinner'),
          SizedBox(height: 10),
          MealCard(mealName: 'Snacks'),
        ],
      );
}
