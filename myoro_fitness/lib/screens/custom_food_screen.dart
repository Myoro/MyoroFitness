import "package:flutter/material.dart";
import "package:myoro_fitness/bloc/food_search_screen_bloc.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/models/nutrient.dart";
import "package:myoro_fitness/widgets/basic_dropdown.dart";
import "package:myoro_fitness/widgets/basic_input.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";
import "package:myoro_fitness/widgets/top_bars/custom_food_screen_top_bar.dart";

class CustomFoodScreen extends StatefulWidget {
  final FoodSearchScreenBloc bloc;

  const CustomFoodScreen({ super.key, required this.bloc });

  @override
  State<CustomFoodScreen> createState() => _CustomFoodScreenState();
}

class _CustomFoodScreenState extends State<CustomFoodScreen> {
  final TextEditingController _foodNameController     = TextEditingController();
  final TextEditingController _calorieController      = TextEditingController();
  final TextEditingController _proteinController      = TextEditingController();
  final TextEditingController _fatController          = TextEditingController();
  final TextEditingController _carbohydrateController = TextEditingController();

  String _proteinUnit      = 'g';
  String _fatUnit          = 'g';
  String _carbohydrateUnit = 'g';

  @override
  void dispose() {
    super.dispose();
    _foodNameController.dispose();
    _calorieController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    _carbohydrateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final List<Map<String, dynamic>> rows = [
      {
        "title": "Food Name",
        "controller": _foodNameController,
        "hasDropdown": false
      },
      {
        "title": "Calories",
        "controller": _calorieController,
        "hasDropdown": false
      },
      {
        "title": "Protein",
        "controller": _proteinController,
        "hasDropdown": true
      },
      {
        "title": "Fat",
        "controller": _fatController,
        "hasDropdown": true
      },
      {
        "title": "Carbohydrates",
        "controller": _carbohydrateController,
        "hasDropdown": true
      }
    ];

    void addFoodToPendingMeal() {
      if(_foodNameController.text.isEmpty || _calorieController.text.isEmpty) return;
      widget.bloc.add(FoodAddedEvent(
        Food(
          name: _foodNameController.text,
          company: "My Custom Foods",
          calories: Nutrient(value: int.parse(_calorieController.text), unit: Unit.kcal),
          protein: _proteinController.text.isNotEmpty ? Nutrient(value: int.parse(_proteinController.text), unit: Nutrient.getUnit(_proteinUnit)) : null,
          fat: _fatController.text.isNotEmpty ? Nutrient(value: int.parse(_fatController.text), unit: Nutrient.getUnit(_fatUnit)) : null,
          carbohydrates: _carbohydrateController.text.isNotEmpty ? Nutrient(value: int.parse(_carbohydrateController.text), unit: Nutrient.getUnit(_carbohydrateUnit)) : null
        )
      ));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: CustomFoodScreenTopBar(addFoodToPendingMeal: addFoodToPendingMeal),
      body: Column(
        children: [
          for(final Map<String, dynamic> row in rows)
            Center(
              child: SizedBox(
                width: 324,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("${row["title"]}:", style: theme.textTheme.bodyMedium)
                    ),
                    const SizedBox(width: 10),
                    BasicInput(
                      controller: row["controller"],
                      textType: (row["title"] != "Food Name") ? BasicInputEnum.digitsOnly : null,
                      width: row["hasDropdown"] ? 155 : 200
                    ),
                    if(row["hasDropdown"]) ...[
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: BasicDropdown(
                          width: 40,
                          height: 25,
                          items: const ["g", "mg"],
                          onChanged: (value) {
                            switch(row["title"]) {
                              case "Protein":
                                _proteinUnit = value;
                                break;
                              case "Fat":
                                _fatUnit = value;
                                break;
                              case "Carbohydrates":
                                _carbohydrateUnit = value;
                                break;
                            }
                          }
                        ),
                      )
                    ]
                  ]
                ),
              ),
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: 324,
            child: Row(
              children: [
                Expanded(
                  child: TextHoverButton(
                    onTap: () => addFoodToPendingMeal(), // TODO
                    title: "Create Food",
                    border: Border.all(color: theme.colorScheme.onPrimary, width: 2)
                  ),
                )
              ]
            ),
          )
        ]
      )
    );
  }
}