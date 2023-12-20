// ignore_for_file: curly_braces_in_flow_control_structures

import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:myoro_fitness/bloc/meal_bloc.dart";
import "package:myoro_fitness/bloc/tdee_bloc.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/widgets/cards/meal_card.dart";
import "package:myoro_fitness/widgets/modals/tdee_modal.dart";

class CaloriesPage extends StatefulWidget {
  const CaloriesPage({ super.key }); 

  @override
  State<CaloriesPage> createState() => _CaloriesPageState();
}

class _CaloriesPageState extends State<CaloriesPage> {
  int breakfastCaloriesConsumed = 0;
  int lunchCaloriesConsumed = 0;
  int dinnerCaloriesConsumed = 0;
  int snacksCaloriesConsumed = 0;
  int caloriesConsumed = 0;
  Color calorieBarColor = Colors.transparent;
  double calorieBarWidth = 0;
  bool isModalShown = false;
  int calorieDeficit = 0;

  @override
  void initState() {
    super.initState();
    Database().get("calorie_plan").then((data) => setState(() { calorieDeficit = data["calorie_deficit"] as int; }));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Since this is the initial page, we check if the tdee & calorie deficit has been set
    Database().get("calorie_plan").then((row) {
      if(row["remind_user"] == 1 && !isModalShown) {
        setState(() { isModalShown = true; });
        showDialog(
          context: context,
          builder: (context) => const TDEEModal(mainDescription: "Would you like to set a calorie plan?")
        );
      }
    });

    return BlocBuilder<TDEEBloc, TDEEState>(
      builder: (context, tdeeState) {
        if(tdeeState.calorieDeficit != null)
          Future.delayed(Duration.zero, () => setState(() { calorieDeficit = tdeeState.calorieDeficit!; }));

        return BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            // Checking if we need to reset the meal foods
            Database().get("meal_date").then((row) {
              int getCaloriesConsumed(List<Food> foods) {
                int resultado = 0;
                for(final Food food in foods)
                  if(food.calories != null)
                    resultado += int.parse((food.calories!.value * food.serving).toStringAsFixed(0));
                return resultado;
              }

              if(row["date"] != DateFormat("dd-MM-yyyy").format(DateTime.now())) {
                Database().update("meal_date", "date", DateFormat("dd-MM-yyyy").format(DateTime.now()));
              } else {
                breakfastCaloriesConsumed = getCaloriesConsumed(state.breakfast.foods);
                lunchCaloriesConsumed = getCaloriesConsumed(state.lunch.foods);
                dinnerCaloriesConsumed = getCaloriesConsumed(state.dinner.foods);
                snacksCaloriesConsumed = getCaloriesConsumed(state.snacks.foods);
                caloriesConsumed = breakfastCaloriesConsumed + lunchCaloriesConsumed + dinnerCaloriesConsumed + snacksCaloriesConsumed;
              }

              if(tdeeState.calorieDeficit != null) {
                final double calorieDeficitProportionConsumed = caloriesConsumed / tdeeState.calorieDeficit!;

                if(Platform.isAndroid || Platform.isIOS)
                  calorieBarWidth = (MediaQuery.of(context).size.width - 38) * ((calorieDeficitProportionConsumed < 1) ? calorieDeficitProportionConsumed : 1);
                else
                  calorieBarWidth = (MediaQuery.of(context).size.width - 110) * ((calorieDeficitProportionConsumed < 1) ? calorieDeficitProportionConsumed : 1);
                calorieBarColor = calorieDeficitProportionConsumed < 1 ? theme.colorScheme.onPrimary : Colors.red;
              }

              setState(() {});
            });

            return Expanded(
              child: Container(
                color: theme.colorScheme.primary,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 17, right: 17),
                      child: Column(
                        children: [
                          if(tdeeState.calorieDeficit != null) ...[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: calorieBarColor,
                                  width: 2
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 10,
                                    color: calorieBarColor,
                                    width: calorieBarWidth
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(tdeeState.calorieDeficit != null && MediaQuery.of(context).size.width > 325)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Calorie Max: $calorieDeficit", style: theme.textTheme.bodySmall),
                                      const Spacer(),
                                    ]
                                  ),
                                ),
                              Text(
                                MediaQuery.of(context).size.width > 200 ? "Calories consumed: $caloriesConsumed" : "$caloriesConsumed cals",
                                style: theme.textTheme.bodySmall
                              )
                            ]
                          ),
                        ]
                      )
                    ),

                    MealCard(mealName: "Breakfast", meal: state.breakfast),
                    MealCard(mealName: "Lunch", meal: state.lunch),
                    MealCard(mealName: "Dinner", meal: state.dinner),
                    MealCard(mealName: "Snacks", meal: state.snacks)
                  ]
                )
              )
            );
          }
        );
      }
    );
  }
}
