import "package:flutter/material.dart";

class CaloriesPage extends StatelessWidget {
  CaloriesPage({ super.key });

  final List<String> mockMeals = [ "Breakfast", "Lunch", "Dinner", "Snacks" ];
  final List<Map<String, String>> mockFoods = [
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Silly Billy Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Dodge Ram", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Que só maRam tem!", "quantity": "5 Spoons", "calories": "1234" },
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Container(
        color: theme.colorScheme.primary,
        child: ListView(
          children: [
            for(int i = 0; i < mockMeals.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 17, right: 17),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // Meal name
                        Text(
                          mockMeals[i],
                          style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.primary)
                        ),
                        
                        Divider(thickness: 0.5, color: theme.colorScheme.primary),
                        
                        // Foods
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              for(int i = 0; i < mockFoods.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mockFoods[i]["name"]!,
                                            style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary)
                                          ),
                                          Text(
                                            mockFoods[i]["quantity"]!,
                                            style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary)
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        mockFoods[i]["calories"]!,
                                        style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary)
                                      )
                                    ],
                                  )
                                ),
                            ]
                          ),
                        ),
                        
                        Divider(thickness: 0.5, color: theme.colorScheme.primary),
                        
                        // Calorie summary
                        Row(
                          children: [
                            Text(
                              "Recommended: 1234",
                              style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary)
                            ),
                            const Spacer(),
                            Text(
                              "${mockMeals[i]} Total: 12345",
                              style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary)
                            ),
                          ]
                        )
                      ]
                    ),
                  )
                ),
              )
          ]
        )
      )
    );
  }
}