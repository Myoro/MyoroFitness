import "package:flutter/material.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/widgets/top_bars/food_information_screen_top_bar.dart";

class FoodInformationScreen extends StatelessWidget {
  final Food food;

  const FoodInformationScreen({ super.key, required this.food });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: FoodInformationScreenTopBar(food: food),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Text(food.name, style: theme.textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text(
                              (food.calories != null) ? food.calories!.value.toString() : "",
                              style: theme.textTheme.labelMedium
                            ),
                            const SizedBox(height: 5),
                            Text(
                              (food.calories != null) ? "Calories" : "",
                              style: theme.textTheme.labelMedium
                            ),
                          ]
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Protein:", style: theme.textTheme.bodyMedium),
                                Text("Fat:", style: theme.textTheme.bodyMedium),
                                Text("Carbs:", style: theme.textTheme.bodyMedium)
                              ]
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  (food.protein != null)
                                    ? "${food.protein!.value}${(food.protein!.unit != null) ? food.protein!.unit!.unit : 'g'}"
                                    : "N/A"
                                  ,
                                  style: theme.textTheme.bodyMedium
                                ),
                                Text(
                                  "34g",
                                  style: theme.textTheme.bodyMedium
                                ),
                                Text(
                                  "46g",
                                  style: theme.textTheme.bodyMedium
                                )
                              ]
                            )
                          ]
                        )
                      ]
                    ),
                  )
                ]
              ),
              const SizedBox(height: 50),
              if(food.ingredients != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(alignment: Alignment.center, child: Text("Ingredients", style: theme.textTheme.labelMedium)),
                    for(final String ingredient in food.ingredients!.ingredients)
                      Text("- $ingredient", style: theme.textTheme.bodyMedium)
                  ]
                )
            ]
          ),
        ),
      )
    );
  }
}
