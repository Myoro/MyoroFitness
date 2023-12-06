import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/top_bars/food_search_screen_top_bar.dart";
import "package:myoro_fitness/models/food.dart";

import "dart:math";

class FoodSearchScreen extends StatelessWidget {
  final List<Food> mockFoods = List.generate(30, (index) => Food(
    name: [ "Random food #1", "Mock fod", "Cereal", "Quaker Oats", "This is a longer food okay okokokokokokok" ][Random().nextInt(5)],
    company: [ null, "Nestle", "Mondalez", "Guarana", "Random qiwejqwiejqwiejqwiejqwieqwjeiqwje"][Random().nextInt(5)],
    calories: [ null, 1000, 100, 200, 123 ][Random().nextInt(5)]
  ));

  // const FoodSearchScreen({ super.key });
  FoodSearchScreen({ super.key }); // TODO: Remove above comment when mockFoods is gone

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: const FoodSearchScreenTopBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ListView(
          children: [
            for(int i = 0; i < mockFoods.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 17, right: 17),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:        theme.colorScheme.onPrimary
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mockFoods[i].name,
                                style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                                overflow: TextOverflow.ellipsis
                              ),
                              if(mockFoods[i].company != null)
                                Text(
                                  mockFoods[i].company!,
                                  style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary),
                                  overflow: TextOverflow.ellipsis
                                )
                            ]
                          ),
                        ),
                        const Spacer(),
                        Text(
                          (mockFoods[i].calories != null) ? "${mockFoods[i].calories!.toString()}kcals" : "N/A",
                          style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary)
                        )
                      ]
                    ),
                  ),
                ),
              )
          ]
        ),
      )
    );
  }
}