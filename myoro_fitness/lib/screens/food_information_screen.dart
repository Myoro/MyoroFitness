import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/top_bars/food_information_screen_top_bar.dart";

class FoodInformationScreen extends StatelessWidget {
  const FoodInformationScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: const FoodInformationScreenTopBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [
              Text("Food name here", style: theme.textTheme.labelLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("1234 Calories", style: theme.textTheme.labelMedium),
                  const Spacer(),
                  Column(
                    children: [
                      Text("Macronutrients", style: theme.textTheme.titleMedium),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("Protein:", style: theme.textTheme.bodyMedium),
                              Text("Fat:", style: theme.textTheme.bodyMedium),
                              Text("Carbohydrates:", style: theme.textTheme.bodyMedium)
                            ]
                          ),
                          Column(
                            children: [
                              Text("12g", style: theme.textTheme.bodyMedium),
                              Text("34g", style: theme.textTheme.bodyMedium),
                              Text("46g", style: theme.textTheme.bodyMedium)
                            ]
                          )
                        ]
                      )
                    ]
                  )
                ]
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  Text("Other Nutritional Data", style: theme.textTheme.labelMedium),
                  Row(
                    children: [
                      Column(
                        children: [
                          for(int i = 0; i < 6; i++)
                            Text("<Nutrient>", style: theme.textTheme.bodyMedium),
                        ]
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          for(int i = 0; i < 6; i++)
                            Text("<quantity><unit>", style: theme.textTheme.bodyMedium),
                        ]
                      )
                    ]
                  )
                ]
              )
            ]
          ),
        ),
      )
    );
  }
}