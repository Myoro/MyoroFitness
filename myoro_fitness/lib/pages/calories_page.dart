import "package:flutter/material.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/widgets/modals/confirmation_modal.dart";

class CaloriesPage extends StatefulWidget {
  const CaloriesPage({ super.key }); 

  @override
  State<CaloriesPage> createState() => _CaloriesPageState();
}

class _CaloriesPageState extends State<CaloriesPage> {
  bool isModalShown = false;

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
    { "name": "Pizza Pizza Pizza Pizza Pizza Pizza Ellipsize Pizza", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Dodge Ram", "quantity": "5 Spoons", "calories": "1234" },
    { "name": "Que só maRam tem!", "quantity": "5 Spoons", "calories": "1234" },
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Since this is the initial page, we check if the tdee & calorie deficit has been set
    Database().get("calorie_plan").then((row) {
      if(row["remind_user"] == 1 && !isModalShown) {
        setState(() { isModalShown = true; });
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmationModal(
              title: "Calorie Plan",
              message: "Would you like to set a calorie plan?",
              onYes: () {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmationModal(
                      title: "Getting your TDEE",
                      message: "This is a tomorrow issue",
                      onYes: () => print("TODO")
                    );
                  }
                );
              },
              onNo: () => Database().update("calorie_plan", "remind_user", 0)
            );
          }
        );
      }
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
                              Text("Calorie Max: 2300", style: theme.textTheme.bodySmall),
                              const Spacer(),
                            ]
                          ),
                        ),
                      Text(MediaQuery.of(context).size.width > 200 ? "Calories consumed: 10000" : "10000 cals", style: theme.textTheme.bodySmall)
                    ]
                  ),
                ]
              )
            ),

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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mockFoods[i]["name"]!,
                                              style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                            ),
                                            Text(
                                              mockFoods[i]["quantity"]!,
                                              style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                            ),
                                          ],
                                        )
                                      ),
                                      const Spacer(),
                                      Text(
                                        mockFoods[i]["calories"]!,
                                        style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(MediaQuery.of(context).size.width > 350)
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Recommended: 1234",
                                      style:    theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary)
                                    ),
                                    const Spacer(),
                                  ]
                                ),
                              ),
                            Expanded(
                              child: Align(
                                alignment: (MediaQuery.of(context).size.width > 350) ? Alignment.centerRight : Alignment.center,
                                child: Text(
                                  "${mockMeals[i]} Total: 12345",
                                  style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
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
