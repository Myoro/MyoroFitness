import "package:flutter/material.dart";
import "package:myoro_fitness/models/food.dart";

class FoodInformationScreenTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Food food;
  final Function addFoodToPendingMeal;

  const FoodInformationScreenTopBar({
    super.key,
    required this.food,
    required this.addFoodToPendingMeal
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Spacer(),
          InkWell(
            onTap: () => addFoodToPendingMeal(),
            child: Icon(Icons.check, size: 35, color: Theme.of(context).colorScheme.onPrimary)
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.pop(context), // TODO
            child: Icon(Icons.close, size: 35, color: Theme.of(context).colorScheme.onPrimary)
          )
        ]
      )
    );
  }
}