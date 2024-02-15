import 'package:flutter/material.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/widgets/app_bars/food_information_screen_app_bar.dart';
import 'package:myoro_fitness/widgets/bodies/food_information_screen_body.dart';

/// Where the user will either add a food to a meal or view said from from said meal
class FoodInformationScreen extends StatelessWidget {
  final FoodModel food;

  const FoodInformationScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const FoodInformationScreenAppBar(),
        body: FoodInformationScreenBody(food: food),
      );
}
