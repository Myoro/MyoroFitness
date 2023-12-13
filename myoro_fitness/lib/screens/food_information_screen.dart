import "package:flutter/material.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/widgets/top_bars/food_information_screen_top_bar.dart";

class FoodInformationScreen extends StatefulWidget {
  final Food food;

  const FoodInformationScreen({ super.key, required this.food });

  @override
  State<FoodInformationScreen> createState() => _FoodInformationScreenState();
}

class _FoodInformationScreenState extends State<FoodInformationScreen> {
  final ValueNotifier _serving = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: FoodInformationScreenTopBar(food: widget.food),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ValueListenableBuilder(
            valueListenable: _serving,
            builder: (context, value, child) => Column(
              children: [
                Text(widget.food.name, style: theme.textTheme.labelLarge, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                if(widget.food.calories != null)...[
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () => _serving.value = value + 1, // TODO
                                  radius: 20,
                                  highlightColor: Colors.transparent,
                                  child: Icon(Icons.arrow_drop_up, size: 50, color: theme.colorScheme.onPrimary),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    value.toString(),
                                    style: theme.textTheme.labelMedium
                                  ),
                                ),
                                InkWell(
                                  onTap: () { if(value > 1) _serving.value = value - 1; }, // TODO
                                  radius: 20,
                                  highlightColor: Colors.transparent,
                                  child: Icon(Icons.arrow_drop_down, size: 50, color: theme.colorScheme.onPrimary),
                                )
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
                              mainAxisAlignment: (widget.food.calories != null) ? MainAxisAlignment.start : MainAxisAlignment.center,
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
                                      (widget.food.protein != null)
                                        ? "${widget.food.protein!.value}${(widget.food.protein!.unit != null) ? widget.food.protein!.unit!.unit : 'g'}"
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
                  const SizedBox(height: 30),
                  Text("${widget.food.calories!.value.toString()} Calories", style: theme.textTheme.titleLarge)
                ],
                const SizedBox(height: 50),
                if(widget.food.ingredients != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.center, child: Text("Ingredients", style: theme.textTheme.labelMedium)),
                      for(final String ingredient in widget.food.ingredients!.ingredients)
                        Text("- $ingredient", style: theme.textTheme.bodyMedium)
                    ]
                  )
              ]
            ),
          ),
        ),
      )
    );
  }
}
