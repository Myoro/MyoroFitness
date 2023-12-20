import "dart:convert";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/models/ingredients.dart";
import "package:myoro_fitness/models/nutrient.dart";

abstract class FoodSearchScreenEvent {}
class FoodsLoadingEvent extends FoodSearchScreenEvent {}
class GetAddedFoodsFromDatabase extends FoodSearchScreenEvent {}
class FoodsLoadedEvent extends FoodSearchScreenEvent {
  final List<Food>? foods;
  FoodsLoadedEvent(this.foods);
}
class FoodAddedEvent extends FoodSearchScreenEvent {
  final Food food;
  FoodAddedEvent(this.food);
}

class FoodSearchScreenState {
  final bool loading;
  final List<Food> foods;
  final List<Food> addedFoods;
  final List<Food> mealFoods;

  FoodSearchScreenState({
    this.loading = false,
    this.foods = const [],
    this.addedFoods = const [],
    this.mealFoods = const []
  });

  FoodSearchScreenState copyWith({
    bool? loading,
    List<Food>? foods,
    List<Food>? addedFoods,
    List<Food>? mealFoods
  }) => FoodSearchScreenState(
    loading: loading ?? this.loading,
    foods: foods ?? this.foods,
    addedFoods: addedFoods ?? this.addedFoods,
    mealFoods: mealFoods ?? this.mealFoods
  );
}

class FoodSearchScreenBloc extends Bloc<FoodSearchScreenEvent, FoodSearchScreenState> {
  FoodSearchScreenBloc() : super(FoodSearchScreenState()) {
    on<FoodsLoadingEvent>((event, emit) => emit(state.copyWith(loading: true)));
    on<FoodsLoadedEvent>((event, emit) => emit(state.copyWith(loading: false, foods: event.foods)));
    on<FoodAddedEvent>((event, emit) async {
      final String foodJson = jsonEncode(event.food.toJson());
      final Map<String, Object?> row = await Database().get("added_foods", { "food": foodJson });

      if(row.isEmpty) Database().insert("added_foods", { "food": foodJson });

      emit(
        state.copyWith(
          addedFoods: row.isEmpty ? [ ...state.addedFoods, event.food ] : state.addedFoods,
          mealFoods: [ ...state.mealFoods, event.food ]
        )
      );
    });
    on<GetAddedFoodsFromDatabase>((event, emit) async {
      final List<Map<String, Object?>> rows = await Database().select("added_foods");
      final List<Food> result = [];
      for(final Map<String, Object?> row in rows) {
        final Map<String, dynamic> rowJson = jsonDecode(row["food"] as String);
        result.add(Food(
          name:          rowJson["name"],
          company:       rowJson["company"],
          calories:      (rowJson["calories"] != null) ? Nutrient(value: rowJson["calories"]["value"], unit: Unit.kcal) : null,
          protein:       (rowJson["protein"] != null) ? Nutrient(value: rowJson["protein"]["value"], unit: Nutrient.getUnit(rowJson["protein"]["unit"])) : null,
          fat:           (rowJson["fat"] != null) ? Nutrient(value: rowJson["fat"]["value"], unit: Nutrient.getUnit(rowJson["fat"]["unit"])) : null,
          carbohydrates: (rowJson["carbohydrates"] != null) ? Nutrient(value: rowJson["carbohydrates"]["value"], unit: Nutrient.getUnit(rowJson["carbohydrates"]["unit"])) : null,
          ingredients:   (rowJson["ingredients"] != null) ? Ingredients(rowJson["ingredients"]) : null
        ));
      }
      emit(state.copyWith(addedFoods: result));
    });
  }
}