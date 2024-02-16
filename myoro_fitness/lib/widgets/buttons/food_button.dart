import "package:flutter/material.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/screens/food_information_screen.dart";

class FoodButton extends StatelessWidget {
  final Food food;

  const FoodButton({ super.key, required this.food });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FoodInformationScreen(food: food))
      ),
      child: Padding(
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                        overflow: TextOverflow.ellipsis
                      ),
                      if(food.company != null)
                        Text(
                          food.company!,
                          style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary),
                          overflow: TextOverflow.ellipsis
                        )
                    ]
                  ),
                ),
                const Spacer(),
                Text(
                  (food.calories != null) ? "${food.calories!.value}kcals" : "N/A",
                  style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}