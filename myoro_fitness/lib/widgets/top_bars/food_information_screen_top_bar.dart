import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/food_search_screen_bloc.dart";
import "package:myoro_fitness/models/food.dart";

class FoodInformationScreenTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Food food;
  final FoodSearchScreenBloc bloc;

  const FoodInformationScreenTopBar({ super.key, required this.food, required this.bloc });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    void addFoodToPendingMeal() {
      bloc.add(FoodAddedEvent(food));
      Navigator.pop(context);
    }

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