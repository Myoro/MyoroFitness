import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/meal_bloc.dart";
import "package:myoro_fitness/bloc/tdee_bloc.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/widgets/cards/meal_card.dart";
import "package:myoro_fitness/widgets/modals/tdee_modal.dart";

class CaloriesPage extends StatefulWidget {
  const CaloriesPage({ super.key }); 

  @override
  State<CaloriesPage> createState() => _CaloriesPageState();
}

class _CaloriesPageState extends State<CaloriesPage> {
  bool isModalShown = false;

  int calorieDeficit = 0;
  int caloriesConsumed = 0;

  Map<String, dynamic> meals = { "Breakfast": [], "Lunch": [], "Dinner": [], "Snacks": [] };

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
          builder: (context) => const TDEEModal()
        );
      }
    });

    return BlocBuilder<TDEEBloc, TDEEState>(
      builder: (context, state) {
        if(state.calorieDeficit != null) {
          Future.delayed(Duration.zero, () => setState(() { calorieDeficit = state.calorieDeficit!; }));
        }

        return BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            return Expanded(
              child: Container(
                color: theme.colorScheme.primary,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 17, right: 17),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:        theme.colorScheme.onPrimary
                                  )
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(MediaQuery.of(context).size.width > 325)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Calorie Max: $calorieDeficit", style: theme.textTheme.bodySmall),
                                      const Spacer(),
                                    ]
                                  ),
                                ),
                              Text(MediaQuery.of(context).size.width > 200 ? "Calories consumed: $caloriesConsumed" : "$caloriesConsumed cals", style: theme.textTheme.bodySmall)
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
