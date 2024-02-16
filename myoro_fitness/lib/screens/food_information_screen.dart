import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/food_search_screen_bloc.dart";
import "package:myoro_fitness/bloc/meal_bloc.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/widgets/basic_input.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";
import "package:myoro_fitness/widgets/top_bars/food_information_screen_top_bar.dart";

class FoodInformationScreen extends StatefulWidget {
  final Food food;
  final int? index;
  final String? meal;

  const FoodInformationScreen({
    super.key,
    required this.food,
    this.index,
    this.meal
  });

  @override
  State<FoodInformationScreen> createState() => _FoodInformationScreenState();
}

class _FoodInformationScreenState extends State<FoodInformationScreen> {
  final TextEditingController servingController = TextEditingController();
  late final ValueNotifier _serving = ValueNotifier<double>(1);

  @override
  void initState() {
    super.initState();
    _serving.value = widget.food.serving;
    servingController.text = (widget.food.serving == 1) ? '1' : widget.food.serving.toString();
  }

  @override
  void dispose() {
    super.dispose();
    servingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void addFoodToPendingMeal() {
      if(widget.index == null) {
        BlocProvider.of<FoodSearchScreenBloc>(context).add(FoodAddedEvent(
          (widget.food.calories != null)
          ?
          widget.food.copyWith(serving: (_serving.value != 1) ? _serving.value : 1)
          :
          widget.food
        ));
      } else {
        BlocProvider.of<MealBloc>(context).add(EditFoodEvent(
          food: (widget.food.calories != null)
            ?
            widget.food.copyWith(serving: (_serving.value != 1) ? _serving.value : 1)
            :
            widget.food,
          index: widget.index!,
          meal: widget.meal!,
          mode: EditFoodEventEnum.edit
        ));
      }
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: FoodInformationScreenTopBar(food: widget.food, addFoodToPendingMeal: addFoodToPendingMeal),
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
                      BasicInput(
                        width: 50,
                        textType: BasicInputEnum.decimal,
                        centered: true,
                        onChanged: (value) { if(servingController.text.isNotEmpty) _serving.value = double.parse(value); },
                        controller: servingController
                      ),
                      const Spacer(),
                      Column(
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
                                    (widget.food.fat != null)
                                      ? "${widget.food.fat!.value}${(widget.food.fat!.unit != null) ? widget.food.fat!.unit!.unit : 'g'}"
                                      : "N/A"
                                    ,
                                    style: theme.textTheme.bodyMedium
                                  ),
                                  Text(
                                    (widget.food.carbohydrates != null)
                                      ? "${widget.food.carbohydrates!.value}${(widget.food.carbohydrates!.unit != null) ? widget.food.carbohydrates!.unit!.unit : 'g'}"
                                      : "N/A"
                                    ,
                                    style: theme.textTheme.bodyMedium
                                  )
                                ]
                              )
                            ]
                          )
                        ]
                      )
                    ]
                  ),
                  const SizedBox(height: 30),
                  Text("${(widget.food.calories!.value * value).toStringAsFixed(0)} Calories", style: theme.textTheme.titleLarge)
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
                  ),
                if(widget.index != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextHoverButton(
                      title: "Delete Food",
                      onTap: () {
                        BlocProvider.of<MealBloc>(context).add(EditFoodEvent(
                          food: widget.food,
                          index: widget.index!,
                          meal: widget.meal!,
                          mode: EditFoodEventEnum.delete
                        ));
                        Navigator.pop(context);
                      },
                      border: Border.all(color: theme.colorScheme.onPrimary, width: 2)
                    ),
                  )
              ]
            ),
          ),
        ),
      )
    );
  }
}
