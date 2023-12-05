import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/top_bar.dart";

class FoodSelectionScreen extends StatelessWidget {
  const FoodSelectionScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBar(),
      body:   Center(child: Text("Later"))
    );
  }
}