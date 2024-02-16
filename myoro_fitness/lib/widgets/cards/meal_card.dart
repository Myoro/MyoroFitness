// ignore_for_file: curly_braces_in_flow_control_structures

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/meal_bloc.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/models/meal.dart";
import "package:myoro_fitness/screens/food_information_screen.dart";
import "package:myoro_fitness/screens/food_search_screen.dart";

class MealCard extends StatelessWidget {
  final String mealName;
  final Meal meal;

  const MealCard({ super.key, required this.mealName, required this.meal });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    int mealCalorieTotal = 0;
    for(final Food food in meal.foods) mealCalorieTotal += (food.calories != null) ? food.calories!.value : 0;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 17, right: 17),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Meal name
              Row(
                children: [
                  Text(
                    mealName,
                    style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.primary)
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        BlocProvider.of<MealBloc>(context).add(SetSelectedMealEvent(mealName));
                        return FoodSearchScreen(selectedMeal: mealName);
                      }
                    )),
                    child: Icon(Icons.add, size: 30, color: theme.colorScheme.primary)
                  )
                ]
              ),
              
              if(meal.foods.isNotEmpty) Divider(thickness: 0.5, color: theme.colorScheme.primary),
              
              // Foods
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    for(final Food food in meal.foods)...[
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FoodInformationScreen(
                            food: food,
                            index: meal.foods.indexOf(food),
                            meal: mealName
                          ))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 2),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food.name,
                                      style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                    if(food.company != null)
                                      Text(
                                        food.company!,
                                        style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
                                      )
                                  ],
                                )
                              ),
                              const SizedBox(width: 30),
                              if(food.calories != null)
                                Text(
                                  "${(food.calories!.value * food.serving).toStringAsFixed(0)}cals",
                                  style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis
                                )
                            ],
                          )
                        ),
                      ),
                      if(meal.foods.indexOf(food) != (meal.foods.length - 1)) const SizedBox(height: 10)
                    ]
                  ]
                ),
              ),
              
              if(meal.foods.isNotEmpty) Divider(thickness: 0.5, color: theme.colorScheme.primary),
              
              // Calorie summary
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "$mealName Total: $mealCalorieTotal",
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right
                  ),
                  const SizedBox(width: 10)
                ]
              )
            ]
          ),
        )
      ),
    );
  }
}
