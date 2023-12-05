import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/top_bars/food_search_screen_top_bar.dart";

class FoodSearchScreen extends StatelessWidget {
  const FoodSearchScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FoodSearchScreenTopBar(),
      body:   Center(child: Text("Later skater"))
    );
  }
}